cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.1"
  sha256 arm:          "b47bc4249812755e288a3c77d1d44e3869a1e0ad8e06a99bcd576079071f288f",
         intel:        "4c2669749427ae415fa6d0b8acdcef6cfe3396bc8f4af1ebd892e53846ed1dec",
         arm64_linux:  "52570fd641966feb703f3ec63f322db178cf52f0546bb700b1b224d5347fdf23",
         x86_64_linux: "0ec26d74dfaf026d32dcb9dd02ebc55b581fe38d09eafb8f34a427774f0944d8"

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
