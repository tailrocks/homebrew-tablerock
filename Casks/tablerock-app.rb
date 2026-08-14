# source-sha: e18cc91bc8efef3ca6b3ed9470468cf274c5af1b
cask "tablerock-app" do
  version "0.1.0"
  sha256 "d7aed88555ce7f3be0d76bcc70e907bcb79648474db5d71e213d1ac5e486e14d"

  url "https://github.com/tailrocks/tablerock/releases/download/v0.1.0/tablerock-app-0.1.0-aarch64-apple-darwin.zip"
  name "TableRock"
  desc "Native PostgreSQL, ClickHouse, and Redis workbench"
  homepage "https://github.com/tailrocks/tablerock"

  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "TableRock.app"

  zap trash: "~/Library/Application Support/TableRock"
end
