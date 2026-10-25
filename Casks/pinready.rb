cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.22.6"
  sha256 arm:          "89c7bec8a3ed4b74322bfe9dcb27ec94a44fb4af2f84f108be6af4ba49dc7278",
         intel:        "c0ff6459458c2fd342b43d5c4adf0db2b08d194b815ef9252536448493902f6d",
         arm64_linux:  "d340be89ca548518ea2ad25590163c5556465a57d53733c2b563f7d49721c552",
         x86_64_linux: "a1dd613d0307bf232bfd4329d5a913e91b36de2ff860310e419251f911bcca5e"

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
