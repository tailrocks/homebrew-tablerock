# source-sha: f6591b04f7a601d413f0f8af9cf780a128018e37
cask "tablerock-app@preview" do
  version "0.1.0-preview.765,f6591b0"
  sha256 "843656b5a0175bf3b89f39d8a84b8e88b446dd097e96720efde555596aaa6c85"

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
