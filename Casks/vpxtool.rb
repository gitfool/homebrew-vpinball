cask "vpxtool" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "macos", linux: "linux"

  version "0.34.7"
  sha256 arm:          "4afb3027810a3e1b9b2723b9b9a0de7b94cae07ff881809e19904515c50265fa",
         intel:        "51c3730a6a5a93d9465b966b9959cfcb4500f87b7710224ebfeb19263bd7e31e",
         arm64_linux:  "a5d69b0062eef0aa99525ede217114a9485490695f7515262506c3d6f16de5bc",
         x86_64_linux: "b88b8af786a969f8e38255aeb075616bbded0f94753e8135e35aee6bbb0ab36d"

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
