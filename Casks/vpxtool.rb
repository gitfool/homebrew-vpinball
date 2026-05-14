cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.31.0"
  sha256 arm:          "c9cfb25d61559dc353de67a866a1f1152f020d75ac6faa4b73b8d86b53fce6fe",
         intel:        "f8a7153c2459129c6963cee11b83990f3d6bf67b0f09656d80e68c89ed88f5c3",
         arm64_linux:  "3e7e4416c099b513e2af192b89bca0883f5bbabeb277c87301228352b2307b45",
         x86_64_linux: "545d99bc329aa3377568ae37c6fc103a36cd9742db9f9ca473cc0c1999d7423a"

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
