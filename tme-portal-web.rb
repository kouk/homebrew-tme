require 'formula'

class TmePortalWeb < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'
  depends_on 'tme-mist'

  def install
    system "make", "--directory=src/portal-web", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc", "LIBPATH=lib/tme", "install"
  end
end







