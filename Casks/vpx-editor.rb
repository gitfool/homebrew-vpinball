cask "vpx-editor" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "zip"

  version "0.9.4-168-ec1d042"
  tag = version.split("-").first
  sha256 arm:          "c6620f0372ce3cb3d17f7c2993a064f6d85e97e47e1abb95839679080d68f648",
         x86_64_linux: "9aa75e2d02fd363e583fa5bc6700e1fb68742311797b2d740dd8851566e35c80"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :monterey

    app "VPX Editor.app"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/VPX Editor.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPX Editor-linux-x64/vpx-editor"
  end

  url "https://github.com/jsm174/vpx-editor/releases/download/v#{tag}/vpx-editor-#{os}-#{arch}-#{version}.#{ext}"
  name "VPX Editor"
  desc "Cross-platform Visual Pinball table editor using Electron and vpin"
  homepage "https://github.com/jsm174/vpx-editor"

  livecheck do
    url :url
    regex(/vpx-editor-#{os}-#{arch}-(\d+(?:\.\d+)+-\d+-[0-9a-f]+)\.#{ext}/i)
    strategy :github_releases do |json, regex|
      json.map do |release|
        next if release["draft"]

        release["assets"]&.filter_map do |asset|
          match = asset["name"]&.match(regex)
          next if match.blank?

          match[1]
        end
      end.flatten.compact.first
    end
  end

  zap trash: [
    "~/.config/VPX Editor",
    "~/Library/Application Support/VPX Editor",
  ]
end
