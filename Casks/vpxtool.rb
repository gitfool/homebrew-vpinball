cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.5"
  sha256 arm:          "f705652f3f5b003fbad5a75e7031844e463c4458ab7e4c56c0caa2a11fe77049",
         intel:        "95864d57ae41042310b593b2136becd6fdc893a01c9ca069c12aa2fe04eaabe3",
         arm64_linux:  "bf756e7105d7e1ef364d42091bc630339fd24fa046dfd8bb036329fdb9929ace",
         x86_64_linux: "c5d05a7b75c5a3f7abb9a33c4840f63408747858c292e981c1d03985b63dd69b"

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
