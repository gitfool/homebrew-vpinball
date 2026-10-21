cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.21.3"
  sha256 arm:          "8ca82281c4618305698a61597f21cfb2edd9bb6159daae4965bc47e27d010f09",
         intel:        "46fc0a468682d4148b28911264df8eb3b9cde60cf76290d1594469ad9d6e9151",
         arm64_linux:  "1916015269961691a0a3ed30320532326e47303f8b2f12338e6ace996a446eba",
         x86_64_linux: "d296a5512d2a10d1dbea97ed6716d0aaa41257d51fcfa2926bc264a3c35c90dc"

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
