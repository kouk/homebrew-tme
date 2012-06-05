require 'formula'

class TmeCommon < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'

  def install
    inreplace 'src/common/bin/create_zookeeper_nodes.sh', '/opt/trend/tme/lib', "#{lib}/tme"
    inreplace 'src/common/bin/daemon.sh', '/var/run/tme', "#{var}/run/tme"
    inreplace 'src/common/bin/daemon.sh', /^chown /, '#chown '
    system "make", "--directory=src/common", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme-common", "install"
  end
end

