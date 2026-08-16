# source-sha: aa608711ede6d345bd3338391736d2e728fe63c1
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.858+aa60871"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "653d8cfd7de4e06f62b8e9f8d36d965a53ce3d7ac00ef7977c0de49171bb2dfd"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "39e1509f2589e72e324f0eed0111975658ccb48f4c9a96ae115888a1ac06f8a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d5ff77981266ba36a4d993b9fba364bcead4748879bd8f7b65f6b08e205fe9e7"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d992cf74118b233bf7dc192d718a42c8695c1a157afd004ead4cf94e4d8e0803"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
