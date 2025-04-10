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
    venv = virtualenv_create(libexec, "/opt/homebrew/bin/python3.11")
    venv.pip_install "pyyaml==6.0.1"
    venv.pip_install "beautifulsoup4==4.13.3"
    venv.pip_install "soupsieve==2.6"
    venv.pip_install "typing-extensions==4.13.1"
    venv.pip_install "bleach>=6.1.0"
    venv.pip_install buildpath

    (bin/"textcleaner").write_env_script "#{libexec}/bin/textcleaner", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
