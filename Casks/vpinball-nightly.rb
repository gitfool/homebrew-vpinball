cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  version "10.8.1-4783-9a90d8d"
  sha256 arm:          "6ed6995acbff49310c6d4c12de5dad5b63e438e3d949d978d59c7d849e97c030",
         intel:        "ee3e107e6500ced364449cde60305abad85e8fe69006637429503a6d2c3c6196",
         x86_64_linux: "57f437f78ae2ada440b044021c05b8109614f718c44f04e098e123942a5858f6"

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
