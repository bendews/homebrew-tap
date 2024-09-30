class Apw < Formula
    desc "CLI for Apple Passwords (also known as iCloud Keychain)"
    homepage "https://github.com/bendews/apw"
    url       "https://github.com/bendews/apw.git",
    tag:      "v1.0.0",
    revision: "55492f35929c8f24b9172292030dd0f879cbbbb1"
    license "GPL-3.0-or-later"
    head "https://github.com/bendews/apw.git", branch: "main"
  
    depends_on "deno" => :build
    depends_on :macos
  
    def install
      system "deno", "compile",
        "--allow-all",
        "--output", bin/"apw",
        "src/cli.ts"
    end
  
    service do
      run [opt_bin/"apw", "start"]
      keep_alive true
      log_path var/"log/apw.log"
      error_log_path var/"log/apw.log"
    end
  
    test do
      assert_match "a CLI for Apple Passwords",
                   shell_output("#{bin}/apw --help")
    end
  end
  