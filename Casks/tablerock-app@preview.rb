# source-sha: 349a6f4c42f6f6fad9ba9707e64d57c71c37b69d
cask "tablerock-app@preview" do
  version "0.1.0-preview.633,349a6f4"
  sha256 "6e646bba05605ec3e3f93f7893e0d69c4eaa06d02274226de5aa8d98261044ac"

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
