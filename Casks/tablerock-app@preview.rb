# source-sha: 165dda737787d6819e3124bb14c7a3e8936f6901
cask "tablerock-app@preview" do
  version "0.1.0-preview.807,165dda7"
  sha256 "a645288c1f754f97ddcc70e6fdc86be6c2cb7c17703ffb567e933ee7a56ebc4d"

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
