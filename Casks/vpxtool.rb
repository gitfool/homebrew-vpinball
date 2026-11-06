cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.39.1"
  sha256 arm:          "3216f2003c99c9a32a3451c84bb829781be966ed40392f4018a6b92b14154b7b",
         intel:        "8e02b1ba487fd2bb6c24ad7e99ae883d5a0cb29f7103befe7b00ff15f150f16c",
         arm64_linux:  "ddb13422e234af48553ee22f549a7010ae29c58064e9e1ad9c1edeea2944495c",
         x86_64_linux: "9e8fc37daf3825db66ed50dc2107fdbb46360593d6dbbbcda7f0d53d09978709"

  on_macos do
    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{HOMEBREW_PREFIX}}/bin/vpxtool"]
    end
  end

  url "https://github.com/francisdb/vpxtool/releases/download/v#{version}/vpxtool-#{os}-#{arch}-v#{version}.tar.gz"
  name "vpxtool"
  desc "Terminal based frontend and utilities for Visual Pinball"
  homepage "https://github.com/francisdb/vpxtool"

  livecheck do
    url :url
    strategy :github_latest
  end

  binary "vpxtool"

  zap trash: [
    "~/.config/vpxtool",
    "~/Library/Application Support/vpxtool",
  ]
end
