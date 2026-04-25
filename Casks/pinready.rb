cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.7.0"
  sha256 arm:          "cee3741ac8b847a8bc85f9bb945d6d2c20e346fde154fadd7e0bb40b06872173",
         intel:        "db1b14cb2ca068289cb0c7cf9c3126f59d2a822df88ab67366b62810d8a90260",
         arm64_linux:  "79d3789ce9ed91d7fe069573614efc83fc08dff084fc0f357d6a327a83693356",
         x86_64_linux: "d464271b269ea02d61b5510ede324dcf99a44ca5c7fe2da70f4192c2f976ad9f"

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
