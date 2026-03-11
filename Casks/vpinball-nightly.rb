cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "10.8.1-4786-ee57db5"
  sha256 arm:          "5c7c6509b21db33c9f433e516f21b69e104002de58a03168df05aeb0889d8164",
         intel:        "3d0d636682a6d3c54f1322aa84c4e9ae4d7b4fc775e5ab91abdef71434f8bb27",
         x86_64_linux: "cbfc325abc0b6607a4cda0f191177c5e5b76d26bcabf5d466b1b78619b835721"

  url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master/VPinballX_BGFX-#{version}-#{os}-#{arch}-Release.zip",
      verified: "nightly.link/vpinball/vpinball/"
  name "VPinballX BGFX nightly"
  desc "Visual Pinball BGFX nightly"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master?preview"
    regex(/VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release.zip"/)
  end

  depends_on macos: ">= :sonoma"

  on_macos do
    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPinballX_BGFX.app"]
    end
  end

  on_linux do
    binary "VPinballX_BGFX"
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
