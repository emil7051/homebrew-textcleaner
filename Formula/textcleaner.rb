class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/llm-text-processor"
  url "https://github.com/emil7051/llm-text-processor/archive/refs/tags/v0.1.0.zip"
  sha256 "dfba9dec8109f169251d0e6fe51b47e05f2a8cf20a79af5baeb0c6fd00b63214"
  license "MIT"

  depends_on "python@3.9"
  depends_on "tesseract" => :recommended
  depends_on "poppler" => :recommended

  def install
    virtualenv_create(libexec, "python3.9")
    
    # Install the package and its dependencies from PyPI
    system libexec/"bin/pip", "install", "-v", "beautifulsoup4", "click", "pypdf", "pyyaml"
    
    # Install the package from the downloaded zip
    system libexec/"bin/pip", "install", "-v", "."
    
    # Create a wrapper script for the CLI
    (bin/"textcleaner").write <<~EOS
      #!/bin/bash
      "#{libexec}/bin/python" -m llm_text_processor.cli "$@"
    EOS
    
    chmod 0755, bin/"textcleaner"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
