cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.17.2"
  sha256 arm:          "156b06ecb44cd0af61f9da26691f8cd8876e6b50a95b7860497d5ae13d7a60d7",
         intel:        "95f28842e4945778fb752aff1d07959d574f7682e69db4446e8cc71a72106e73",
         arm64_linux:  "95071febe86f16edeacb1183ffab5a93bc3edc7e023c757c84531f863a3b3a89",
         x86_64_linux: "9cca01498d7b56dfee2857d85fe5576a33d499ae55d8668ecad361db13487c5f"

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
