# source-sha: 9e321389829e9b5f8dee52dac9e6d01bd8dba490
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.623+9e32138"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "a028ed3fe610144ffc92d7087b85015b036e7ab06510ea8b2dd3af6b9a155173"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "bbe58150e4c789260d7d9f3b24a0950d37b236a473a292fb1edd731569b498a2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9ba20417a38a7581bb5466e7837c7f27445c53922f11ecde7b8a30c6656d5816"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fae87709e91ffc96f6407e5e38bcd67b68432fa82b9cf3fc4a7fd0276090c0c"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
