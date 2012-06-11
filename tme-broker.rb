require 'formula'

class TmeBroker < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'

  def install
    inreplace 'src/broker/bin/broker.sh',                 '/opt/trend/tme/conf', "#{etc}/tme"
    inreplace 'src/broker/bin/broker.sh',                 '/opt/trend/tme/lib',  "#{lib}/tme-broker"
    inreplace 'src/broker/bin/broker.sh',                 '/var/log/tme',        "#{var}/log/tme"
    inreplace 'src/broker/bin/broker.sh',                 '/var/run/tme',        "#{var}/run/tme"
    inreplace 'src/broker/bin/imqcmd',                    '/opt/trend/tme/lib',  "#{lib}/tme-broker"
    inreplace 'src/broker/conf/broker/tme-broker.monit',  '/var/run/tme',        "#{var}/run/tme"
    # TODO: fix start/stop program in tme-broker.monit
    inreplace 'src/broker/conf/broker/config.properties', '/var/log/tme',        "#{var}/log/tme"
    inreplace 'src/broker/conf/broker/logback.xml',       '/var/log/tme',        "#{var}/log/tme"

# Can't have install/remove scripts since they depends on init.d script.
#   inreplace 'src/broker/bin/install_tme-broker.sh', '/opt/trend/tme/conf/', "#{etc}/tme/"
#   inreplace 'src/broker/bin/install_tme-broker.sh', '/opt/trend/tme/bin/',  "#{bin}/tme-broker/"
#   # Remove any line related to monit to remove monitoring things.
#   inreplace 'src/broker/bin/install_tme-broker.sh', /^.*monit.*$/,          ''
#   inreplace 'src/broker/bin/remove_tme-broker.sh',  /^.*monit.*$/,          ''

    system "make", "--directory=src/broker", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme-broker", "install"

    # No need to have init.d scripts.
    remove_dir "#{prefix}/etc/init.d"
    # Can't have install/remove scripts since they depends on init.d script.
    remove     "#{bin}/install_tme-broker.sh"
    remove     "#{bin}/remove_tme-broker.sh"
    # That's skip monit configuration, too.
    remove     "#{prefix}/etc/tme/broker/tme-broker.monit"
  end
end


