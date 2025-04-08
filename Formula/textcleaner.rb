class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/llm-text-processor"
  url "https://github.com/emil7051/llm-text-processor/archive/main.zip"
  version "0.1.0"
  sha256 "" # Will be auto-calculated by Homebrew
  license "MIT"

  depends_on "python@3.9"
  depends_on "tesseract" => :recommended
  depends_on "poppler" => :recommended

  def install
    venv = virtualenv_create(libexec, "python3")
    
    # Install dependencies from requirements.txt if it exists
    if File.exist?("requirements.txt")
      system libexec/"bin/pip", "install", "-r", "requirements.txt"
    end
    
    # Install the package
    system libexec/"bin/pip", "install", "-e", "."
    
    # Create a wrapper script for the CLI
    (bin/"textcleaner").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/lib/python3.9/site-packages:$PYTHONPATH"
      exec "#{libexec}/bin/python" -m llm_text_processor.cli "$@"
    EOS
    
    chmod 0755, bin/"textcleaner"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
