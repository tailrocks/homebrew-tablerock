# homebrew-tablerock

Homebrew tap for [TableRock](https://github.com/tailrocks/tablerock), a native
PostgreSQL, ClickHouse, and Redis workbench.

## Install

CLI/TUI preview:

```bash
brew tap tailrocks/tablerock
brew trust tailrocks/tablerock
brew install tablerock@preview
```

Native macOS preview:

```bash
brew install --cask tablerock-app@preview
```

The native preview is ad-hoc signed and not notarized. On first launch, use
right-click **Open**, or remove quarantine explicitly:

```bash
xattr -dr com.apple.quarantine /Applications/TableRock.app
```

Homebrew can refuse formulae from untrusted taps. Run
`brew trust tailrocks/tablerock` once after tapping this repository.

## Updating

```bash
brew update
brew upgrade tablerock@preview
brew upgrade --cask tablerock-app@preview
```

## License

Licensed under the Apache License, Version 2.0. See `LICENSE`.
