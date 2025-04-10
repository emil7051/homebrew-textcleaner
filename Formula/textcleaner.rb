class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/refs/tags/v0.5.7.tar.gz"
  sha256 "fb997e7b9c8bb0913cfb776213fc862cf38e57790e62995a2e97ffe52e4de111"
  license "MIT"
  head "https://github.com/emil7051/textcleaner.git", branch: "main"

  depends_on "python@3.11"

  def install
    # Create venv and install pip/setuptools/wheel
    virtualenv_install_with_resources

    # Install the package using the venv's pip, resolving dependencies from pyproject.toml
    system libexec/"bin/pip", "install", "."

    # Create the executable script
    (bin/"textcleaner").write_env_script libexec/"bin/textcleaner", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
