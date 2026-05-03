cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.28.0"
  sha256 arm:          "4fa90feaaf66da63b8e6fee5f0f9f0984ff4ddda6c6b7240e0103dba1ad45d0a",
         intel:        "b6143bcbd4f4f48f7a18f59d293ed6b0aa133a77f1f3ba30fa23db46713cda15",
         arm64_linux:  "8f777c4cfa5897f8ca3402a209477094f3fc60d9edd8bdd6cc8abc7a91e92c67",
         x86_64_linux: "146f58a4cb1db1b5dcfac9bc76c260d1421f550623af797f2fec67b6aaf3a94b"

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
    end
  end

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
