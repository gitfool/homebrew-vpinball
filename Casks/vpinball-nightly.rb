cask "vpinball-nightly" do
  arch arm: "arm64", intel: "x64"
  os macos: "macos", linux: "linux"
  ext = on_system_conditional macos: "dmg", linux: "tar.gz"
  artifact_id = on_system_conditional macos: on_arch_conditional(arm: "14117879713", intel: "14118785285"),
                                      linux: "14118243924"

  version "10.8.1-6814-f4f7aa508"
  sha256 arm:          "7dbdd280042c698acb33cbef332d924963ec7fa49ecaa23c27a8b7a8caab9f81",
         intel:        "a18bb1720219117585893847efe15c64739ea53bcfad100b98d39a56c1ffa709",
         x86_64_linux: "2fe18136adc8ac558c4680a92fa238598f7fefaff67d5c9a2ba5a1a082aba062"

  on_macos do
    depends_on macos: :sonoma

    app "VPinballX_BGFX.app"
    binary "#{appdir}/VPinballX_BGFX.app/Contents/MacOS/VPinballX_BGFX"

    postflight_steps do
      run "xattr", args: ["-d", "com.apple.quarantine", "{{appdir}}/VPinballX_BGFX.app"]
    end
  end
  on_linux do
    depends_on arch: :x86_64

    binary "VPinballX_BGFX"
  end

  url "https://api.github.com/repos/vpinball/vpinball/actions/artifacts/#{artifact_id}/zip",
      header: "Authorization: token #{GitHub::API.credentials}"
  name "VPinballX BGFX (nightly)"
  desc "Visual Pinball BGFX (nightly)"
  homepage "https://github.com/vpinball/vpinball"

  livecheck do
    # Get unfiltered runs; branch/event/status filters intermittently return stale partial results
    url "https://api.github.com/repos/vpinball/vpinball/actions/workflows/vpinball.yml/runs?per_page=10",
        header: ["Authorization: token #{GitHub::API.credentials}", "Accept: application/vnd.github+json"]
    regex(/^VPinballX_BGFX-(.+?)-#{os}-#{arch}-Release\.#{ext}$/)
    strategy :json do |json, regex|
      json["workflow_runs"]
        .select { |run| run["head_branch"] == "master" && run["event"] == "push" && run["conclusion"] == "success" }
        .sort_by { |run| -run["run_number"] }
        .lazy
        .map { |run| GitHub::API.open_rest("#{run["artifacts_url"]}?per_page=100")["artifacts"] }
        .map { |artifacts| artifacts.reject { |artifact| artifact["expired"] } }
        .map { |artifacts| artifacts.filter_map { |artifact| artifact["name"][regex, 1] } }
        .find(&:any?) || []
    end
  end

  zap trash: [
    "~/.local/share/VPinballX",
    "~/.vpinball",
    "~/Library/Application Support/VPinballX",
  ]
end
