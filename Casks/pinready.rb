cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.10.0"
  sha256 arm:          "7ce032f638e528c30774915fb797b8e21156a32f61075ab65263f3b08a014435",
         intel:        "b5b726a1e4cc5572fcccecf2079419f9a25087c7bda7ca540fe38b4685be6802",
         arm64_linux:  "f1eb0005599dc207d91e86b59dfb0bc99babb2e3eaa2a18fb2ca06b7f5d802f1",
         x86_64_linux: "b815ba670cf8090085584f490a02ffbfc6736053e8e075bcbd403ae9ff994c56"

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
