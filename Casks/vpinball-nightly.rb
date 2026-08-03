cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "8834985821", intel: "8834719267"),
                                      linux: "8834787452"

  version "10.8.1-5402-3faa77e9c"
  sha256 arm:          "d4fd454fd7553ff33b67305b65d31089b82ab873ed11a8f93317d430973b20b8",
         intel:        "aadd3821607400a6f0e6f5a62f58ea50524a6daaba9cc28c1f10588839d85707",
         x86_64_linux: "32fa766728a25b1441fe74e66b72b2abcee90abbc530979a4a906b4ed324a1c0"

  on_macos do
    depends_on macos: :sonoma

    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPinballX_BGFX.app"]
    end
  end
  on_linux do
    binary "VPinballX_BGFX"
  end

  url "https://api.github.com/repos/vpinball/vpinball/actions/artifacts/#{artifact_id}/zip",
      header: "Authorization: token #{GitHub::API.credentials}"
  name "VPinballX BGFX (nightly)"
  desc "Visual Pinball BGFX (nightly)"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    url "https://nightly.link/vpinball/vpinball/workflows/vpinball/master?preview"
    regex(/VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release\.#{ext}"/)
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
