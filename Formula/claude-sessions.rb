class ClaudeSessions < Formula
  desc "Auto-resume Claude Code sessions after Mac restart"
  homepage "https://github.com/amer313/claude-sessions"
  url "https://github.com/amer313/claude-sessions/archive/refs/tags/v0.3.0.tar.gz"
  sha256 "9d7b312245940e347a642ced3f389096ed7e677c364268d638ccc4c45f34fe98"
  license "MIT"
  version "0.3.0"

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
      To finish setup, register the LaunchAgents:
        claude-sessions install

      To add the optional menu bar item:
        claude-sessions menubar install

      Uninstall (removes LaunchAgents, preserves data):
        claude-sessions uninstall
    EOS
  end

  test do
    assert_match "claude-sessions", shell_output("#{bin}/claude-sessions 2>&1", 1)
  end
end
