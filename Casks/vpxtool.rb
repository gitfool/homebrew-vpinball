cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.28.1"
  sha256 arm:          "a967a9e63167fb8b6b0b5b0426218fa1336d0dafb86febb63a3882f59044e53c",
         intel:        "3f6418360576cc599010398fb95d793449ffe30542ee31801c7c04bb203f4c37",
         arm64_linux:  "2cdc4c2ac6280401cfdccbb12f177e81d1fa43698ee3e673dac980c17160ace9",
         x86_64_linux: "beaa1969ed696484a313f9470f1d2417177db1cfb41a3882b954d16dcde3d08c"

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
