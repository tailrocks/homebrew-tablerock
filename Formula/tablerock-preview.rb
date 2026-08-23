# source-sha: 2c100eb07970ba6b0cfc5351b757e338dfd09a92
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.865+2c100eb"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "098dbad5dedb38132104bc3223714a77c1d7dd29e29ce85f155dec99eec3afc0"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "2ddf0fca1a34ecc8a2f5ca47299e0057dd1c7d8e405f3e1547c9d2bb610e2933"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ec032f810cd062ad110245d38f0b051bcc6dfaae3e94e5cd85fb0f5b5fe21485"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0fa76b527c90051ad29474e0574bee7c2845b2108d883467c00f05dfe3cec240"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
