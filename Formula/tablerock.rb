# source-sha: e18cc91bc8efef3ca6b3ed9470468cf274c5af1b
class Tablerock < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/v0.1.0/tablerock-0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "d82930d32cadd4ad9bf606910a4a11372653ad191f5e3c0d775f40c7ab76baab"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/v0.1.0/tablerock-0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "b86cd564381b811b2dc1a0b8692cc995f17c2f45dcd732d788f353e3f6c2cf84"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/v0.1.0/tablerock-0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0bf90bb4b133929c3d1589f1bb7d6c058ea06ae0e2a2d08a4dec928dd51cf0b"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/v0.1.0/tablerock-0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e0bfadd628e20b56da11f607b74c6cdaadab229531f11b733f9409131c898633"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
