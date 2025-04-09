class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/1a793ac3ca62d7bbeea96af1aba41a7b3e77ce04.tar.gz"
  version "0.1.3"
  sha256 "ce5960820cc5079a72a3240ec24a578211ef7982c8875c823deacebbc497e315"
  license "MIT"
  head "https://github.com/emil7051/textcleaner.git", branch: "main"

  # Define the minimum Python version required, matching pyproject.toml
  # Adjust python version if needed (e.g., python@3.9, python@3.10)
  depends_on "python@3.11"

  # Dependencies are now handled by setup.py/pyproject.toml via pip

  def install
    # Create a virtual environment
    venv = virtualenv_create(libexec, Formula["python@3.11"].opt_bin/"python3.11", without_pip: false)
    # Install the package AND its dependencies using the virtualenv's pip
    system libexec/"bin/pip", "install", buildpath

    # Create a wrapper script to make the command available in the PATH
    # Ensures the command runs within the virtual environment
    (bin/"textcleaner").write_env_script libexec/"bin/textcleaner", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    # Test if the command runs and shows the version
    system bin/"textcleaner", "--version"
  end
end
