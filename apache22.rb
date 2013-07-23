require 'fileutils'
require 'formula'

class Apache22 < Formula
  homepage 'https://httpd.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=httpd/httpd-2.2.24.tar.bz2'
  sha1 'f73bce14832ec40c1aae68f4f8c367cab2266241'

  skip_clean ['bin', 'sbin']

  def install
    args = [
      "--prefix=#{prefix}",
      "--mandir=#{man}",
      "--disable-debug",
      "--disable-dependency-tracking",
      "--with-mpm=prefork",
      "--with-included-apr",
      "--enable-mods-shared=all",
      "--enable-proxy",
      "--enable-ssl",
    ]
    system './configure', *args
    system "make"
    system "make install"

    # create logs directory
    FileUtils.mkpath "#{prefix}/logs"
  end
end
