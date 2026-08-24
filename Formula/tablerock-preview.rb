# source-sha: a37344a9a2366c0e563613c25325e0b357803e8a
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.867+a37344a"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "b681209ed99519d9543c3a59e586995bd266886343b6143980cb8020bb382117"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "cac00764fc4d8757352eba45a2d55c16acb241c8446bce79b832074d31f67812"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d94e7d3dbdc6e749f1952f9e2c93c6e3af0fc40472002da1880d083eb1fc569a"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "69690faaf661dcef9b7bd2d56e4995c1af22a150e42347d833f45dfa0374d786"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
