require 'fileutils'
require 'formula'

class Apache24 < Formula
  homepage 'https://httpd.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=httpd/httpd-2.4.4.tar.bz2'
  sha1 '0c5ab7f876aa10fbe8bfab2c34f8dd3dc76db16c'

  skip_clean ['bin', 'sbin']

  depends_on 'pcre'
  depends_on 'homebrew/dupes/apr'
  depends_on 'homebrew/dupes/apr-util'

  def install
    args = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--with-mpm=prefork",
      "--enable-mods-shared=all",
      "--with-pcre=#{Formula.factory('pcre').prefix}",
      "--with-apr=#{Formula.factory('homebrew/dupes/apr').prefix}",
      "--with-apr-util=#{Formula.factory('homebrew/dupes/apr-util').prefix}",
    ]
    system './configure', *args
    system "make"
    system "make install"

    # create logs directory
    mkpath "#{prefix}/logs"
  end

  def plist_name; 'org.apache.'+name end
  plist_options :manual => "apachectl start"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
          <string>#{bin}/apachectl</string>
          <string>start</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
    EOS
  end
end
