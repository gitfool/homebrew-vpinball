cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.21.0"
  sha256 arm:          "3be34c2410f60fd1cac9991987b4f5fe1211415497aeffaefddad9c97739a195",
         intel:        "ba014026c2e520097f61dfd445e86b0f616814cfe50f845c3712810e8853d8ea",
         arm64_linux:  "aa57d3435f4fee74cc366c588bd63fa50b86022897e8afb706ed4188949293d3",
         x86_64_linux: "3741e6a8473ad53262036ab9382f9cb6312499ffdb42c91c573a8ece90ac50bd"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/pinready"]
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
