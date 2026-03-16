cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.26.3"
  sha256 arm:          "bf7889a668b34dbc4bf0874a1ccbce2597988123fe6886f2ca657199e28de346",
         intel:        "1bf7607c945a61cea4a53b73f2cb0bba61ce23053efef9f79f44adc77a8ed48d",
         arm64_linux:  "69a2bb77fbee7ac0f416cdeb469f942a3884a22c29d7320108d8b4ac8c1baa2d",
         x86_64_linux: "de059b6d0056ce5d6ba36b83a51547591d460e5d932889e7c3819eadc4997d2d"

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
