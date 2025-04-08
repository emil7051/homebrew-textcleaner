class Textcleaner < Formula
  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/llm-text-processor"
  url "https://github.com/emil7051/llm-text-processor/archive/refs/tags/v0.1.0.zip"
  sha256 "dfba9dec8109f169251d0e6fe51b47e05f2a8cf20a79af5baeb0c6fd00b63214"
  license "MIT"

  depends_on "python@3.9"

  def install
    # Note: This formula provides the textcleaner command but users need to install Python dependencies separately
    # using: pip install beautifulsoup4 click pypdf pyyaml
    
    # Copy source files to libexec directory
    libexec.install Dir["*"]
    
    # Create wrapper script
    (bin/"textcleaner").write <<~EOS
      #!/bin/bash
      echo "First time? Install dependencies with: pip install beautifulsoup4 click pypdf pyyaml"
      PYTHONPATH="#{libexec}:$PYTHONPATH" exec python3 -m llm_text_processor.cli "$@"
    EOS
    chmod 0755, bin/"textcleaner"
  end

  def caveats
    <<~EOS
      Before using textcleaner, please install required Python dependencies:  
        pip install beautifulsoup4 click pypdf pyyaml
    EOS
  end

  test do
    system "#{bin}/textcleaner", "--help"
  end
end
