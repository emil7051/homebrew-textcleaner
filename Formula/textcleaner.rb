class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/llm-text-processor"
  url "https://github.com/emil7051/llm-text-processor/archive/refs/tags/v0.1.0.zip"
  sha256 "dfba9dec8109f169251d0e6fe51b47e05f2a8cf20a79af5baeb0c6fd00b63214"
  license "MIT"
  head "https://github.com/emil7051/llm-text-processor.git", branch: "main"

  depends_on "python@3.9"

  def install
    # Create a virtualenv in libexec
    venv = virtualenv_create(libexec, Formula["python@3.9"].opt_bin/"python3")
    
    # Install the necessary dependencies directly using pip_install
    # This avoids the need to declare all resources explicitly
    venv.pip_install "beautifulsoup4"
    venv.pip_install "click"
    venv.pip_install "pypdf"
    venv.pip_install "pyyaml"
    
    # Install the package itself
    venv.pip_install_and_link buildpath
    
    # The textcleaner entry point is already created by pip_install_and_link
    # We'll just verify it exists
    assert_predicate bin/"textcleaner", :exist?
  end
  
  test do
    assert_match "LLM Text Preprocessing Tool", shell_output("#{bin}/textcleaner --help")
  end
end
