cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.21.2"
  sha256 arm:          "3f6d14dd37256a604323cf3c251667e4b349e0719bbd1f4b68875cc4ba755c99",
         intel:        "b6d350266ba0cd9af5a7b995f1297f71c8587093f57cb5d37b84ddb576c2303a",
         arm64_linux:  "557c324d61cd6bf9262b092476f845c04418a8ce172607163b5c231859702895",
         x86_64_linux: "bf4c91e3a9b096a253026f400c16f633cffea37ba9e814095f77b5a41a483456"

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
