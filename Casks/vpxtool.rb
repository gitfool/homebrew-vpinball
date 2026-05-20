cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.33.1"
  sha256 arm:          "86f79ed5deb15cd50391a0feebbaf5ff197564c0d57d82de725b89395d13b11f",
         intel:        "285ecbfdec3a2188f45fbcb4923e3bb0529f8c72bc0d524cc9aad1ce9992d984",
         arm64_linux:  "74f03efbad374a4624e5c778137d46783ebf5c8ddfa547c8fec6cefe6e40057d",
         x86_64_linux: "d548d7ed7fbd6b4803f076338782675500064ef52a8405b0d4fdff78da94b77e"

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
