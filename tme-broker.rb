require 'formula'

class TmeBroker < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'

  def install
    system "make", "--directory=src/broker", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme-broker", "install"
  end
end


