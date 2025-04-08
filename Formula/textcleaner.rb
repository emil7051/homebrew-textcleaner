class Textcleaner < Formula
  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/llm-text-processor"
  url "https://github.com/emil7051/llm-text-processor/archive/refs/tags/v0.1.0.zip"
  sha256 "dfba9dec8109f169251d0e6fe51b47e05f2a8cf20a79af5baeb0c6fd00b63214"
  license "MIT"

  depends_on "python@3.9"

  def install
    # Install the package directly using pip
    system Formula["python@3.9"].opt_bin/"pip3", "install", "--prefix=#{prefix}", 
           "--no-deps", "."

    # Install dependencies directly
    system Formula["python@3.9"].opt_bin/"pip3", "install", "--prefix=#{prefix}",
           "beautifulsoup4", "click", "pypdf", "pyyaml"
    
    # Create a simple wrapper script
    (bin/"textcleaner").write <<~EOS
      #!/bin/bash
      exec "#{Formula["python@3.9"].opt_bin}/python3" -m llm_text_processor.cli "$@"
    EOS
    chmod 0755, bin/"textcleaner"
  end

  test do
    assert_match "usage", shell_output("#{bin}/textcleaner --help")
  end
end
