require 'formula'

class TMECommon < Formula
  url 'https://github.com/trendmicro/tme/zipball/osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

  depends_on 'cmake'
  depends_on 'rvm'

  def install
    system "make", "--directory=src/common", "BUILD_PREFIX=#{prefix}", "install"
  end
end

