# source-sha: e2ccfceb79de926ecfbfe6e1df906b535332b663
class TablerockPreview < Formula
  desc "PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"
  version "0.1.0-preview.763+e2ccfce"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-apple-darwin.tar.gz"
      sha256 "1577740ca924615f537be8a1e4d118566c08d0688c3f28dde67145748762c20e"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-apple-darwin.tar.gz"
      sha256 "447e6319e76823f354d3c0175b24dfa25da65f3169ded3208246ea64c4c93c81"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a30489e816b9b164b41e34454b879c55ddbb94abc9676f57d6aadfb5909613d7"
    end
    on_intel do
      url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5323c1affa12f7c31adc893440c2ddc9e6143a77bc0816a3ab230f04ba553d44"
    end
  end

  def install
    bin.install "tablerock"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/tablerock --version")
  end
end
