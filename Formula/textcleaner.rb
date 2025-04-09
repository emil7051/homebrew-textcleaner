class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/refs/tags/v0.2.5.tar.gz"
  version "0.2.5"
  sha256 "b0a56b423a112d3a0ce53ca248f5cf627a97c28bb05620a28356c364642fcc49"
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
