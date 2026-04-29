class ClaudeSessions < Formula
  desc "Auto-resume Claude Code sessions after Mac restart"
  homepage "https://github.com/amer313/claude-sessions"
  url "https://github.com/amer313/claude-sessions/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "c8038ef237a696f1d44cad3015394226d04c381430c07001993403f72a383b37"
  license "MIT"
  version "0.2.0"

  depends_on :macos

  def install
    bin.install "claude-sessions"
    # Install the menu bar script to libexec; the main script finds it via
    # a download fallback if not alongside, but shipping it makes install
    # offline-capable and avoids a second HTTP round-trip.
    libexec.install "claude-sessions-menubar.py"
    # Place a symlink next to the bin script so `claude-sessions menubar install`
    # finds it via its `$(dirname "$0")` lookup.
    bin.install_symlink libexec/"claude-sessions-menubar.py"
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
