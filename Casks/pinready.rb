cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.6.7"
  sha256 arm:          "e930c122a0b27fd5e36fa52cb857bbafbfc2b41f25a4bcf47b7e63b37366a62d",
         intel:        "413904ccf2030cb853fa3e9f5ff0fafd067da47188b5b3673b7277a50aad7493",
         arm64_linux:  "9eba0d24da1a02a245676b4ba8c91505d3d794316d4af8ebabbdc70f2481c715",
         x86_64_linux: "d37a15ebaf8ad2178dc911a05ec91b1bbca4f10ed38fcf2c62ff373f445b55ff"

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
