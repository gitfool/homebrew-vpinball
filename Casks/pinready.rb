cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.17.3"
  sha256 arm:          "8cab52a4ad9fa15319f1f6ac38f5c71358c697cbd3db9c4d6251079d51111a50",
         intel:        "d73cc10b1ff9e02dafd7166937183918ad7e5c1a7ac22213a08da247104d8bf5",
         arm64_linux:  "aa30f39b6040f30297ce7790ecb9025c3668fb9d9a12ea5b471b763d0eada08d",
         x86_64_linux: "a2dee701e8de05c4ad24a4addeb22c7192c1e0fcec28af78ce6dd9db9a92e141"

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
