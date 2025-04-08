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

  # Python resources
  resource "beautifulsoup4" do
    url "https://files.pythonhosted.org/packages/af/0b/44c39cf3b18a9280950ad63a579ce395dda4c32193ee9da7ff0aed547094/beautifulsoup4-4.12.2.tar.gz"
    sha256 "492bbc69dca35d12daac71c4db1bfff0c876c00ef4a2ffacce226d4638eb72da"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/96/d3/f04c7bfcf5c1862a2a5b845c6b2b360488cf47af55dfa79c98f6a6bf98b5/click-8.1.7.tar.gz"
    sha256 "ca9853ad459e787e2192211578cc907e7594e294c7ccc834310722b41b9ca6de"
  end

  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  def install
    virtualenv_install_with_resources
    
    # Add pypdf separately since we had issues with its resource definition
    system Formula["python@3.9"].opt_bin/"pip3", "install", "pypdf"
    
    # Create the textcleaner command wrapper
    (bin/"textcleaner").write <<~EOS
      #!/bin/bash
      export PYTHONPATH="#{libexec}/lib/python3.9/site-packages:$PYTHONPATH"
      exec "#{libexec}/bin/python3" -m llm_text_processor.cli "$@"
    EOS
    
    chmod 0755, bin/"textcleaner"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
