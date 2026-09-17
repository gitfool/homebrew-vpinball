cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.1"
  sha256 arm:          "665c0a5617679fdff924e989f6f1cf81c7edcc77aab0753208d8b726b8db21db",
         intel:        "519c9e341a92387a6529de8cae5b355a37dda974a3364a169785f87d9e933d8a",
         arm64_linux:  "10962ec06956d696b501ef5948bb749394d9b234fe943f8a5d2f9fa04e6c3e40",
         x86_64_linux: "a58ea81fea4a67f83a6a62bced037d4eca9b51249800ab479ab5a7d5804a27c0"

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
