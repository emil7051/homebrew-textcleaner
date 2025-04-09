class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "5c2683271cf561973448da05b5adb8602c67b8c4ac2e2573ae1605faab3e5c0f"
  license "MIT"
  head "https://github.com/emil7051/textcleaner.git", branch: "main"

  # Define the minimum Python version required, matching pyproject.toml
  # Adjust python version if needed (e.g., python@3.9, python@3.10)
  depends_on "python@3.9"

  # Dependencies are now handled by setup.py/pyproject.toml via pip

  def install
    # Create a virtual environment
    venv = virtualenv_create(libexec, Formula["python@3.9"].opt_bin/"python3.9")
    # Install the package and its dependencies using pip from the downloaded source
    venv.pip_install buildpath

    # Create a wrapper script to make the command available in the PATH
    # Ensures the command runs within the virtual environment
    (bin/"textcleaner").write_env_script libexec/"bin/textcleaner", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    # Test if the command runs and shows the version
    system bin/"textcleaner", "--version"
  end
end
