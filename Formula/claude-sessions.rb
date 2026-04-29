class ClaudeSessions < Formula
  desc "Auto-resume Claude Code sessions after Mac restart"
  homepage "https://github.com/amer313/claude-sessions"
  url "https://github.com/amer313/claude-sessions/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "bd4cbbfb8d209b4fd8466dbd1092abab113c934e6a33bd9af0dc376d18c48e38"
  license "MIT"
  version "0.4.0"

  depends_on :macos

  def install
    bin.install "claude-sessions"

    # Menu bar script and icon go to share/claude-sessions/ so the main
    # script's `brew --prefix` lookup finds them.
    (share/"claude-sessions").install "claude-sessions-menubar.py"
    (share/"claude-sessions").install "assets/menubar-icon.png"
    (share/"claude-sessions").install "assets/menubar-icon@2x.png" if File.exist?("assets/menubar-icon@2x.png")

    # Symlink the menubar script next to the bin so the script's
    # `$(dirname "$0")` lookup still works for dev installs.
    bin.install_symlink share/"claude-sessions/claude-sessions-menubar.py"
  end

  def caveats
    <<~EOS
      Finish setup (one command — registers LaunchAgents + menu bar):
        claude-sessions setup

      Or piece-by-piece:
        claude-sessions install           # LaunchAgents only
        claude-sessions menubar install   # menu bar (opt-in)

      Config: ~/.claude/session-manager/config

      Why not auto-setup? Homebrew's post_install sandbox blocks writes to
      ~/Library/LaunchAgents. Your shell can. One command, one time.
    EOS
  end

  test do
    assert_match "claude-sessions", shell_output("#{bin}/claude-sessions 2>&1", 1)
  end
end
