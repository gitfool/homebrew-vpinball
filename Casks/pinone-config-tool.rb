cask "pinone-config-tool" do
  arch arm: "-arm64", intel: ""
  ext = on_system_conditional macos: "dmg", linux: "AppImage"

  version "2.1.2"
  sha256 arm:          "07f129514f12009f218ab50a17e797bbc8782346330bb9964a7fcb1cc0eb8572",
         intel:        "e437bc4e05e8e5841e8c995c073d088af107eea2ab824100c6f09c665b161152",
         x86_64_linux: "c564fcd9782ec454de8b87bfe6b9f2093b60d790049662467bf65ccec984e243"

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

  zap trash: [
    "~/Library/Application Support/pinone-config-tool",
  ]
end
