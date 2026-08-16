# source-sha: aa608711ede6d345bd3338391736d2e728fe63c1
cask "tablerock-app@preview" do
  version "0.1.0-preview.858,aa60871"
  sha256 "d7cf7f7fd987e7ddbb4672369b8299853e6cea7d9125552d8a10f5ae83e5bad5"

  url "https://github.com/tailrocks/tablerock/releases/download/preview/tablerock-app-aarch64-apple-darwin.zip"
  name "TableRock Preview"
  desc "Native PostgreSQL, ClickHouse, and Redis workbench preview"
  homepage "https://github.com/tailrocks/tablerock"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "TableRock.app"

  caveats <<~EOS
    This preview is ad-hoc signed and not notarized.
    On first launch, right-click TableRock and choose Open, or run:
      xattr -dr com.apple.quarantine /Applications/TableRock.app
  EOS

  zap trash: "~/Library/Application Support/TableRock"
end
