# source-sha: 9e321389829e9b5f8dee52dac9e6d01bd8dba490
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.623+9e32138"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "ecc579cce1c0ec6561dda8a8b3431c92038c469164e0f77c5c29c1eadef30dd8"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "35bfb9eeded39a9b9969faa662997ac21224ef0638e15c7f93b32f9dcdeeac1c"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "383c79ddcec3399f104d7855036033459ab81dff2ab85b8e0bfe213aa7f54e0a"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "41305ed8bff94d4c838bf5af5c682edc03fa862f92340d7b36134e9cc3edd939"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
