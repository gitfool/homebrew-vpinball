cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.12.1"
  sha256 arm:          "e60c396e3936497a6a3c5f69d19d914e27b80e66ce939f1b5c3c88068439a520",
         intel:        "988d93b1b363dbf37e94c233fdbcefcf38fb9c8aaeb15479deb53c75b40bfff3",
         arm64_linux:  "265975edb60a0d35a26b9e7d71a8719348b987d461587cf80c05361f2e7f4aed",
         x86_64_linux: "a3a15c47344abc67f17f960aeb9b0705843a2690a66f01791d922247b4ecc867"

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
