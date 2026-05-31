cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.13.1"
  sha256 arm:          "54633bdb5f48494d407da9bc422623be819b4b61edfc2f4d78232a8cc0b1ebe5",
         intel:        "eca7b157941a1cf68aec3cabeb373ab27161f930fdba462c896925000ca37237",
         arm64_linux:  "68a28efcf30cdddb5bcb4c92dc13f1213e94b674a201d296939c2d8ac14dbd2e",
         x86_64_linux: "0b01b29221e46fa96511b192831e7eab2dfb4802d5281cd0214d2de6511a89c6"

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
