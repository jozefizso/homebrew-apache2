require 'fileutils'
require 'formula'

class Apache22 < Formula
  homepage 'https://httpd.apache.org/'
  url 'http://www.apache.org/dyn/closer.cgi?path=httpd/httpd-2.2.25.tar.bz2'
  sha1 'e34222d1a8de38825397a1c70949bcc5836a1236'

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
