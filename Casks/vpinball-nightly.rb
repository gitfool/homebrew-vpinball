cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "8929725884", intel: "8929739858"),
                                      linux: "8929769942"

  version "10.8.1-5411-c4effdcf5"
  sha256 arm:          "0a8d52546adcbd56f8ab7fb82718f4b0c6219e5ec87c28e6ec99ca1992009a42",
         intel:        "71b7c15e6f33f286c6aa8d11247f888d5d25d81e62963b376eda93fabe89f68a",
         x86_64_linux: "c3e38e28b0ad2307b1e632c512c80df5c942b90711aebb02946084d3861d033d"

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
