cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.6"
  sha256 arm:          "75b0e43a9e82a978e04b03079f77de27312c5eb4130e34eb91c717d168c764b1",
         intel:        "43ec31bbbb25d975963a6990703a637c16aaae324391e00a901d2c896d9afc0d",
         arm64_linux:  "1e6513fcecd7f322e2f12fa72317c9df2dc881ee8b3841c769f6621e313a12fa",
         x86_64_linux: "dcee991331ea1e92306dbb3503a6fe3193d8f5bc7a3f1a012b5bf6941d50551c"

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
