cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.35.1"
  sha256 arm:          "3ac8bb5d6c7e980aa339fafa3d854062fc9c70e911cba6d675333a48ab961cf9",
         intel:        "92d609389b772700aa50fd774b987f9a106e4ea7f90d31c0e001beabcf3c0d53",
         arm64_linux:  "0334192218e4a2687ea894cf47b52d9a1a521d6c028c1f7410453e2d14cb8923",
         x86_64_linux: "70827f90bd5eb30482dc2af95c9dc31c4b6a280d5e45b8efb540dc747afad2d5"

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
