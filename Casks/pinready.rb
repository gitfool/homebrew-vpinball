cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.16.0"
  sha256 arm:          "ef67b20feffae9bcbc631bb72c2b5f243ca5e8fc2c9c67da321c8544a0878689",
         intel:        "68e895de55072fb3abf19fe069fbcb5e0d9b4aba1935d6ea20434e8aefaade3e",
         arm64_linux:  "43aa05819726b62e3211d0aa09b182895e7df0ae872b25fa9840111be20e431d",
         x86_64_linux: "65301e6025c0084797eb26f13a63ebaa7932462ad0cef6376d44948a9657cf64"

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
