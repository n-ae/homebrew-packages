class Rgcidr < Formula
  desc "High-performance Zig library and CLI tool for filtering IPv4 and IPv6 addresses against CIDR patterns"
  homepage "https://github.com/yourusername/rgcidr"
  url "https://github.com/yourusername/rgcidr/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "SHA256_HASH_TO_BE_UPDATED"
  license "MIT"
  
  depends_on "zig" => :build

  def install
    system "zig", "build", "-Doptimize=ReleaseFast"
    bin.install "zig-out/bin/rgcidr"
    
    # Install shell completions if available
    if (buildpath/"completions").exist?
      bash_completion.install "completions/rgcidr.bash" => "rgcidr" if (buildpath/"completions/rgcidr.bash").exist?
      fish_completion.install "completions/rgcidr.fish" if (buildpath/"completions/rgcidr.fish").exist?
      zsh_completion.install "completions/_rgcidr" if (buildpath/"completions/_rgcidr").exist?
    end
    
    # Install man page if available
    man1.install "docs/rgcidr.1" if (buildpath/"docs/rgcidr.1").exist?
  end

  test do
    # Test version output
    assert_match version.to_s, shell_output("#{bin}/rgcidr --version 2>&1", 1)
    
    # Test basic IPv4 filtering functionality
    (testpath/"test.txt").write("192.168.1.1\n10.0.0.1\n172.16.0.1\n")
    output = shell_output("#{bin}/rgcidr '192.168.0.0/16' #{testpath}/test.txt")
    assert_match "192.168.1.1", output
    refute_match "10.0.0.1", output
    
    # Test IPv6 support
    (testpath/"ipv6.txt").write("2001:db8::1\nfe80::1\n192.168.1.1\n")
    ipv6_output = shell_output("#{bin}/rgcidr '2001:db8::/32' #{testpath}/ipv6.txt")
    assert_match "2001:db8::1", ipv6_output
    refute_match "fe80::1", ipv6_output
  end
end