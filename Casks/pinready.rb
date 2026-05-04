cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.9.5"
  sha256 arm:          "bb48bd099b1c294db37153838425b801480ab0cb0bc40c14ed796924a4c09656",
         intel:        "3f7e8d45c5f06e1809f1c9b8f17601dbadbfc468451965147a8120a627c738fe",
         arm64_linux:  "d259db069a6161dd4f2f68a4eb4c47e1872833ce54f892adbc981974ddbceaf7",
         x86_64_linux: "803269c9e63a5e22cb4df99511b43159eef8ed1fde925904dd9a4b6f587a090c"

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
