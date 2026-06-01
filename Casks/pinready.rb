cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.13.9"
  sha256 arm:          "8f30f46cef04645aebe9610f1684232c1c0b5aa9b25d7a771b26c0ba8e744f16",
         intel:        "3ad2a3d77f7bedfd2ecf317aa1ccb5a6ca63bd15234aae32fb4cb03fda591a1f",
         arm64_linux:  "3160749adc06f5347c39d5a26ef5414d47fcd6acc2cad7543dfa1785749bd8e0",
         x86_64_linux: "ee680a96f842c6d7e57f4708e96cc745d5870a9d4b3a73bcb72faa6b7aef29b3"

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
