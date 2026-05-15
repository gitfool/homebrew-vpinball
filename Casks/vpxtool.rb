cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.31.1"
  sha256 arm:          "d8d62ebf74104036aeac468a1923522a64964b58479719b6c68dd62735b13351",
         intel:        "097a8b5428259c4fc69d0d6d739f142ca2084dcc09b33b5820e6b7b83ab65cc6",
         arm64_linux:  "1ddd5989617bd16e835517de374dc0d98bfc42b288ce382dc1c6f467fb26226d",
         x86_64_linux: "21b5fd017516e26da006462b1555c8678c0f09faf30e0994d116fff932fa1aa6"

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
