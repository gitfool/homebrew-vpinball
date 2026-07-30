cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.8"
  sha256 arm:          "b2d070e5857bf78f144196f740d16bf6aded1142143c5c5d6307418b76f989d4",
         intel:        "49ba7cb00fdd5400e97425cdfadd6814ca81ff84ee45cd788ce8bab2f92e70d9",
         arm64_linux:  "9a3411bd2a735ff320d9624112835b2a3a388aaca28d715ca1e2d4df26c7270a",
         x86_64_linux: "06b8f77b22b86a1f64dc4f623d8a35fb7e976d9f25c48d51c8966c8ad85cf6f0"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
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
