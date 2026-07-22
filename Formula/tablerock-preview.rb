# source-sha: 165dda737787d6819e3124bb14c7a3e8936f6901
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.807+165dda7"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "3523f9b799d89dc2be473c953baea747dc3c23bfa101359d1331cfa762a9ada5"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "9473b8d417c1f2c0cb452dc8d8786e796b68d92c5b94777f0ecc0c1b2721c63a"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "123c7e22556ecbca84d513e1391cdfb7f473b4fe64fe4b252398169a62a29875"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "99281615fd92f776880acdd79f853cd10bda4ce059418202622e919f1e39ee8d"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
