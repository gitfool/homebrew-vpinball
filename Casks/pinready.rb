cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.18.0"
  sha256 arm:          "9d80d80f7380688b919a4697269d09490cc2eca00568410c7bdd7353ceb2da4c",
         intel:        "6985a400d87541005cda9ec55b07038f0ee69deb8de2475a98213ebeedc815d6",
         arm64_linux:  "d438c0aa798a6a81f44ce25927002328bc6971dfb9282994880158792d8ae7b0",
         x86_64_linux: "a0b4970fee6ce1233abb5b8c0a8031aee4e1e18a178040a0c663410983b34bff"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/pinready"]
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
