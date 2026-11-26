cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.40.4"
  sha256 arm:          "527b3eaf10e0e44e9f5a085a110a884a579cc07dbfb376ae9ba103b729f59aa8",
         intel:        "4023059d5a1d1f432f2b4aefbc6d8656f3ac782f5d108e64c492200d7f3a8317",
         arm64_linux:  "532d1457606665729c05bd949e5140cfa5485af69675c0ef6943398090696bf1",
         x86_64_linux: "956fe5b8daa68ced130441501e5c561496a01f345177318192436c64d97331ed"

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
