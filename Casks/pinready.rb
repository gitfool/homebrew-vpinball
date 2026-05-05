cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.11.1"
  sha256 arm:          "dcae0d5d616147c6e06be9de1c3bc2c593302880f6dc360dff8fe382871aff72",
         intel:        "679f941d78219403ed6f0a972c8f51b8f6de7b91988fdae50d4798fcea0cc0c4",
         arm64_linux:  "2b1ac92130bfad70b0a9d4f624f74d03cb1753ffd47c97f2a62c97382677589a",
         x86_64_linux: "4469539b7324f320e3b6c348baf1f91e5a6b6ccb68577c20884d50fc64b7d6eb"

  url "https://github.com/Le-Syl21/PinReady/releases/download/v#{version}/pinready-#{os}-#{arch}.tar.gz"
  name "pinready"
  desc "Cross-platform configurator and launcher for Visual Pinball"
  homepage "https://github.com/Le-Syl21/PinReady"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "pinready"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/pinready"]
    end
  end

  zap trash: [
    "~/.local/share/pinready",
    "~/Library/Application Support/pinready",
  ]
end
