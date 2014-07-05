require 'fileutils'
require 'formula'

class Apache24 < Formula
  homepage 'https://httpd.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=httpd/httpd-2.4.9.tar.bz2'
  sha1 '646aedbf59519e914c424b3a85d846bf189be3f4'

  skip_clean ['bin', 'sbin']

  depends_on 'pcre'
  depends_on 'apr'
  depends_on 'apr-util'

  def install
    args = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--with-mpm=prefork",
      "--enable-mods-shared=all",
      "--with-pcre=#{Formula.factory('pcre').opt_prefix}",
      "--with-apr=#{Formula.factory('apr').opt_prefix}",
      "--with-apr-util=#{Formula.factory('apr-util').opt_prefix}",
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
