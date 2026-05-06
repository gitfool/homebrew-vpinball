cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.29.3"
  sha256 arm:          "8bb7a4eb71f1715bc5e253f1688398a973a772c18d584cefde0449a9fac488f1",
         intel:        "feb95f0db7c592f1797b07743c7d733827e07ffec0304d9b450580bc43ef9251",
         arm64_linux:  "be9c47a2b3d212ad3020635a1b1f32aa05382613430eb80367ad0e33110f6b85",
         x86_64_linux: "4d92e8cdcf72ca17c84e566124f425e31312935c7b84d022d13ec01871c4addc"

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  on_macos do
    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{HOMEBREW_PREFIX}/bin/vpxtool"]
    end
  end

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
