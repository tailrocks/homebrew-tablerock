# source-sha: f6591b04f7a601d413f0f8af9cf780a128018e37
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.765+f6591b0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "899c7d64bc5ec12298b4ea1122d5719f53a09ed3d2e901c77d10979bf3304232"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "2c3e245554360d759f187489d6b1cf70608b65a1268fa167578dc3b9591b03b4"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2021fb0772424ad88c79e85d1e990af9c4aa5c8e6d67a27acff1f9d243d6532e"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "324c49c4fd63c05ca4b6d63f1fab4cda5160c2d514d9fb9cba73810c933b8c63"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
