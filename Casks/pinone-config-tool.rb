cask "pinone-config-tool" do
  arch arm: "-arm64"
  ext = on_system_conditional macos: "dmg", linux: "AppImage"

  version "2.2.2"
  sha256 arm:          "c0d2494dbedc50b5469b4be09df4d87b100ddd448abd143e04a8540b9645037a",
         intel:        "b9b7c03e722b827e0ef9742a9423b04cb7190723f3365463ad3200705744f33e",
         x86_64_linux: "9ae4b75af5c0b7c1d03d04b9d3830deb516a2ccf2a8b2859dcb857d5d2772bc4"

  on_macos do
    app "pinone-config-tool.app"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/pinone-config-tool.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "pinone-config-tool-#{version}#{arch}.AppImage", target: "pinone-config-tool.AppImage"
  end

  url "https://github.com/philipellisis/arduino-virtual-pinball-board/releases/download/v#{version}/pinone-config-tool-#{version}#{arch}.#{ext}"
  name "PinOne Config Tool"
  desc "Configuration tool for the Arduino PinOne controller"
  homepage "https://github.com/philipellisis/arduino-virtual-pinball-board"

  livecheck do
    url :url
    strategy :github_latest
  end

  zap trash: "~/Library/Application Support/pinone-config-tool"
end
