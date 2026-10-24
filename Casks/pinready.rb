cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.22.5"
  sha256 arm:          "1ec039f535d59683ddc0051908665edf9b5acfbe86565a334464f416b16a3b08",
         intel:        "cfacad6425ac361bf4fb0b2ebda92daab7e054c0a819b8e5c9371f9f1dba771c",
         arm64_linux:  "a089fa490aa4c02f4168449c4303207a3dd8fd9656188fd226f9e474f5789306",
         x86_64_linux: "affe327fb0a8783af736398d892d87712e342edd7b02d202ebf7133059af58cb"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/pinready"]
    end
  end

  url "https://github.com/Le-Syl21/PinReady/releases/download/v#{version}/pinready-#{os}-#{arch}.tar.gz"
  name "pinready"
  desc "Cross-platform configurator and launcher for Visual Pinball"
  homepage "https://github.com/Le-Syl21/PinReady"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "pinready"

  zap trash: [
    "~/.local/share/pinready",
    "~/Library/Application Support/pinready",
  ]
end
