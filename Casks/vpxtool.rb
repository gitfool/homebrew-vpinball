cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.27.2"
  sha256 arm:          "f20e3c521e2c8ea9d12352b97d8bd268d4467611ce489608e8f2d0ca1c2bb9f4",
         intel:        "d71e63dec897548a81223bb57f8cd7af16fbec2401edbc377b9233661c84e0b3",
         arm64_linux:  "48af9162072331801db21bc55be4cb6e55ec9286910b10ff19b3be0e1e08c980",
         x86_64_linux: "ece746fb7af8baa6199573841df8409867cd99cf923727d4940aafc865c34512"

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
