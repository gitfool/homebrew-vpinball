cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.22.4"
  sha256 arm:          "1eed0b1c94a59514d61aad4cce01d84d496e3f961e9cdf19e97e63016a53ac75",
         intel:        "3c039a4d19edb539c0ad1efe89a3bdf888ba40a42c0fcfeb4c7d97f8686ac89f",
         arm64_linux:  "7f18df4b4109fc10179f8ba06194425a629ba3350d5b9556ecd4bed893358367",
         x86_64_linux: "ee45bf51134a68e6bbe6633ace9222300fdfff28df44d26f3b34193b70c27c3d"

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
