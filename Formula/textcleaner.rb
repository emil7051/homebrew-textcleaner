class Textcleaner < Formula
  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/llm-text-processor"
  url "https://github.com/emil7051/llm-text-processor/archive/refs/tags/v0.1.0.zip"
  sha256 "dfba9dec8109f169251d0e6fe51b47e05f2a8cf20a79af5baeb0c6fd00b63214"
  license "MIT"

  depends_on "python@3.9"

  def install
    # Install Python dependencies first
    system Formula["python@3.9"].opt_bin/"pip3", "install", 
           "beautifulsoup4", "click", "pypdf", "pyyaml"

    # Create bin directory
    bin.mkpath
    
    # Copy source files to libexec
    libexec.install Dir["*"]
    
    # Create a simple wrapper script in bin
    (bin/"textcleaner").write <<~EOS
      #!/bin/bash
      PYTHONPATH="#{libexec}:$PYTHONPATH" exec "#{Formula["python@3.9"].opt_bin}/python3" -m llm_text_processor.cli "$@"
    EOS
    chmod 0755, bin/"textcleaner"
  end

  test do
    assert_match "usage", shell_output("#{bin}/textcleaner --help")
  end
end
