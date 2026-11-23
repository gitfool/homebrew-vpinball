cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.3"
  sha256 arm:          "a6f9f7aad92f6ef0bb938bbff5462901d30cd1c97daebc055667ea80e751230c",
         intel:        "d997740533f549f4d5dc5b6bb1368838e8cf0ebea7f5dfd0f7a63add2d40ae60",
         arm64_linux:  "881bbf867233e1c2b048a9d034be543926100d1b6f4516acf7d3041ff92beb3a",
         x86_64_linux: "34f508962d649c98f5ff76813e50a3e505ea93ec043fe1ed22586518096a9eb0"

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
