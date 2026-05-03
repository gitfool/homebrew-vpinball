cask "pinready" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.8.1"
  sha256 arm:          "fe2fd7e1e3ded300a6f0c4774b8dbf74cfef5e89fcd883f279e549e1df504e06",
         intel:        "f9fcfc11f23b166c8d281ee1010b6a8efe3f383299a7f05efefcfce2de6eedc4",
         arm64_linux:  "96f692c973244840d9afdc972111c3b93b95fd2dcb4fc30779b7af9e35c96701",
         x86_64_linux: "03793ad76f9b2f672ff5704735f897bae28a44e0782628eca7ddc6d4fcaf2408"

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
