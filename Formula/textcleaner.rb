class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/refs/tags/v0.5.7.tar.gz"
  sha256 "fb997e7b9c8bb0913cfb776213fc862cf38e57790e62995a2e97ffe52e4de111"
  license "MIT"
  head "https://github.com/emil7051/textcleaner.git", branch: "main"

  depends_on "python@3.11"

  # Declare PyYAML as a resource
  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/source/P/PyYAML/PyYAML-6.0.1.tar.gz"
    sha256 "cdF91fe81d94e04610b95474ab9b4e4bd2f5d09129334a4b284f7e6e6c656030"
  end

  def install
    # Create venv (pip/setuptools/wheel are installed by Homebrew automatically here)
    venv = virtualenv_create(libexec, "python3.11")

    # Install resources first (PyYAML)
    venv.pip_install resource("pyyaml")

    # Install the package itself, pip should find PyYAML already installed
    venv.pip_install "."

    # Create the executable script
    (bin/"textcleaner").write_env_script libexec/"bin/textcleaner", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
