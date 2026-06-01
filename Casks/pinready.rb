cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.13.4"
  sha256 arm:          "1249ebfefa7fd1e4745e6fcffc7cae4ceeb26cfc2a9c10bca228daf510b9274e",
         intel:        "11696c84fef29d40c491c09f270ecf88fe38233b9e6fa02defa1dedb1be831c3",
         arm64_linux:  "914f09c2ba4c01a636e3cc7274252a2f34bb1f622af2b0f672c13eb56194b41b",
         x86_64_linux: "be1ef76fc5ad81f79a8a9878ffac00c35422b45b869ed173beb609b546fb50ad"

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
