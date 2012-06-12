require 'formula'

class TmeCommon < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'

  def patches
    DATA
  end

  def install
    # Create library folder first to force linking JAR files.
    mkdir_p "#{HOMEBREW_PREFIX}/lib/tme"

    system "make", "--directory=src/common", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme", "install"

    # Can't have these scripts since they depends on init.d infrastructure.
    remove     "#{bin}/daemon.sh"
  end
end

__END__
diff --git a/src/common/bin/create_zookeeper_nodes.sh b/src/common/bin/create_zookeeper_nodes.sh
index 6f7de73..fedbfc5 100755
--- a/src/common/bin/create_zookeeper_nodes.sh
+++ b/src/common/bin/create_zookeeper_nodes.sh
@@ -20,7 +20,7 @@ create $2/broker ''
 create $2/exchange ''
 EOF
 `
-    echo -e "$CMDS" | java -cp '/opt/trend/tme/lib/*' org.apache.zookeeper.ZooKeeperMain -server $1
+    echo -e "$CMDS" | java -cp 'HOMEBREW_PREFIX/lib/tme/*' org.apache.zookeeper.ZooKeeperMain -server $1
 
 else
     echo Usage: $0 [ZooKeeperQuorum] [Prefix Path for TME]
diff --git a/src/common/bin/daemon.sh b/src/common/bin/daemon.sh
index b406bf0..5ae43d3 100755
--- a/src/common/bin/daemon.sh
+++ b/src/common/bin/daemon.sh
@@ -1,5 +1,5 @@
-mkdir -p /var/run/tme
-chown TME:TME /var/run/tme
+mkdir -p HOMEBREW_PREFIX/var/run/tme
+#chown TME:TME HOMEBREW_PREFIX/var/run/tme
 
 if [ -e /etc/redhat-release ]
 then
diff --git a/src/common/conf/common/common-env.sh b/src/common/conf/common/common-env.sh
index 90a2939..b9f2e60 100644
--- a/src/common/conf/common/common-env.sh
+++ b/src/common/conf/common/common-env.sh
@@ -1,3 +1,3 @@
-JAVA_HOME=/usr/java/latest
+JAVA_HOME=`/usr/libexec/java_home`
 JAVA_CMD=$JAVA_HOME/bin/java
 


