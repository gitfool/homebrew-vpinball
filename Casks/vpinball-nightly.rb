cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"

  ext = on_system_conditional macos: "dmg", linux: "zip"

  version "10.8.1-4787-eb9f66e"
  sha256 arm:          "81f6d9f0855e94be6d2b58bda714ab94b890f75e03efd107485073de2e53d561",
         intel:        "1f9a7341ee3c43548c20822436bfdb6a75e3b0bc332d82d91e1fd6de55af67e9",
         x86_64_linux: "863b47e29bd976ef1c2d7431d67f0f281facee7959de32928b5950c22a5c650c"

  url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master/VPinballX_BGFX-#{version}-#{os}-#{arch}-Release.#{ext}",
      verified: "nightly.link/vpinball/vpinball/"
  name "VPinballX BGFX (nightly)"
  desc "Visual Pinball BGFX (nightly)"
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
