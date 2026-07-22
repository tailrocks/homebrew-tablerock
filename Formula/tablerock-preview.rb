# source-sha: 942b1a9e42864b86fe9a98c5c86db815a0343991
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.794+942b1a9"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "edcec05383e27ce51404f7e95db6e3b5bb752006715e5cf282e3f1b5f4f1b7f4"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "ce89b916e9dc7fc287b0cd8db4e8dbaa8567b75a7431176f261542211892cba4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7685f2f4bf11b504ceb3f00fc80ada1e00a9c8cbb001ec8553960796a7ee3130"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "87a870880f478c7410221fcbe6e8600b12fa713bb348f9adff3ea58db5b980b0"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
