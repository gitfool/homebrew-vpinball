cask "vpx-editor" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "zip"

  version "0.8.35-131-5b37718"
  sha256 arm:          "2b37974bdc3a7873f656fe07e90878ebf6dd5aa68a2f0aef6a05a68359b6720f",
         x86_64_linux: "e4b7bf951c66a6ea1a9c00300997600ae139af961a900e3a028edd8ab9bcf0cb"

  on_macos do
    depends_on arch: :arm64
    depends_on macos: :monterey

    app "VPX Editor.app"

    postflight do
      system_command "xattr", args: ["-d", "com.apple.quarantine", "#{appdir}/VPX Editor.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPX Editor-linux-x64/vpx-editor"
  end

  url "https://github.com/jsm174/vpx-editor/releases/download/v#{version.split("-").first}/vpx-editor-#{os}-#{arch}-#{version}.#{ext}"
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
