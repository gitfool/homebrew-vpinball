cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.2"
  sha256 arm:          "0a1d61796cbcb5412db870c08bcaf28c8d9804501fad9d4e250a7ac0560584c1",
         intel:        "802faaa440a0f9e989ea9a0a128a291e3131c660c9ae5a0e968567ffa947670b",
         arm64_linux:  "44b029109c2cf06f61549a2ec70e319163e9ec28d38e67cc4a70c52b3a1a4c90",
         x86_64_linux: "b05faa2e0d4f3ec9bcd1eee64e227d019b518be97472359740b8127f54e09151"

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
