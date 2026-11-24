cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.30.1"
  sha256 arm:          "472945e34871aba6468f0582143b5d4b6139236d751ecfceeb8078c3c7610f7e",
         intel:        "4a564a4e38be7b165e1365cdcc744654420df4108386f4379c60c973cef22630",
         arm64_linux:  "9af3f78a2538723acf16e719681259b7de588713e0ef720607caa732952ccd8d",
         x86_64_linux: "9389c5a645fc4ed2b01b3e6d52ab09fac393f9a275274710de9ddae68e8f82ae"

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
