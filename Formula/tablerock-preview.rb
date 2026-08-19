# source-sha: 2c100eb07970ba6b0cfc5351b757e338dfd09a92
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.865+2c100eb"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "5c98eb7797bb08daee3537bfbb91087224b900376541643c26c55228fe211843"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "e5faa810e016cb6cb4f131ef2f0b2b37735f46093368cf775a8206096d7599ac"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b7de21dd10150381b5a030ec59b4c5227b2c1c2910ec887b598b0f89cd296d9b"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d1b58ecc6bb471c6a817a7a07ee241afcf13ea4a5727377f8b2e34dd3594af65"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
