cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.37.0"
  sha256 arm:          "0e0b2be560347ce0a2881b30b47433e2495c263de4a7ec659e6053a5b0529bf9",
         intel:        "5291488b643a4b72430f9b7d46591cc2efd84834ab89403b767377edd59db898",
         arm64_linux:  "bef7d3c11cd3884e52f366902dae74e192304f707fcd68a143b76d6df5fd125b",
         x86_64_linux: "bceee8c53928371f4bf5f1b1723294ea34360a81ca3f7dcf74a2b844bda6e38e"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/vpxtool"]
    end
  end

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
