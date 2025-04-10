class Textcleaner < Formula
  include Language::Python::Virtualenv

  desc "Text cleaning tool for LLM processing"
  homepage "https://github.com/emil7051/textcleaner"
  url "https://github.com/emil7051/textcleaner/archive/refs/tags/v0.5.6.tar.gz"
  sha256 "02997782c168f54a171bef0976fd18cebdf0405e56742772ae4b5421d7644809"
  license "MIT"
  head "https://github.com/emil7051/textcleaner.git", branch: "main"

  depends_on "python@3.11"
  
  resource "pyyaml" do
    url "https://files.pythonhosted.org/packages/cd/e5/af35f7ea75cf72f2cd079c95ee16797de7cd71f29ea7c68ae5ce7be1eda0/PyYAML-6.0.1.tar.gz"
    sha256 "bfdf460b1736c775f2ba9f6a92bca30bc2095067b8a9d77876d1fad6cc3b4a43"
  end

  resource "beautifulsoup4" do
    url "https://files.pythonhosted.org/packages/9c/d8/909c4089dbe4ade9f9705f143a7edb49a0f0a2caffc70d0c5253860468ec/beautifulsoup4-4.12.3.tar.gz"
    sha256 "74e3d1928edc070d21748185c46e3fb33490f22f52a3addee9aee0f4f7781051"
  end

  resource "soupsieve" do
    url "https://files.pythonhosted.org/packages/ce/21/952a240de1c196c7e3fbcd4e559681f0419b1280c617db21157a0390717b/soupsieve-2.5.tar.gz"
    sha256 "5663d5a7b3bfaeee0bc4372e7fc48f9cff4940b3eec54a6451cc5299f1097690"
  end

  resource "typing-extensions" do
    url "https://files.pythonhosted.org/packages/9a/7f/5e5a1aeb0bdb6ed77adbb4f5d4d608cf0a21ec3edb9348abfa02604086bf/typing_extensions-4.13.0.tar.gz"
    sha256 "c3b986f2fa4082127cd69e78041bc2a3c5a6438d25ccd61e38b59fb5eec8f6ea"
  end

  def install
    venv = virtualenv_create(libexec, "/opt/homebrew/bin/python3.11")
    resources.each do |r|
      r.stage do
        venv.pip_install_and_link(Pathname.pwd)
      end
    end
    venv.pip_install buildpath

    (bin/"textcleaner").write_env_script "#{libexec}/bin/textcleaner", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    system "#{bin}/textcleaner", "--version"
  end
end
