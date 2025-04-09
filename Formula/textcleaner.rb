class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "e984625da6e202bd6ead094bacde6cfe0b69c299dd67c53a428da7faa4bc619d"
  license "MIT"
  head "https://github.com/emil7051/textcleaner.git", branch: "main"

  # Define the minimum Python version required, matching pyproject.toml
  # Adjust python version if needed (e.g., python@3.9, python@3.10)
  depends_on "python@3.9"

  # Dependencies are now handled by setup.py/pyproject.toml via pip

  def install
    virtualenv_install_with_resources
  end

  test do
    # Test if the command runs and shows the version
    system bin/"textcleaner", "--version"
  end
end
