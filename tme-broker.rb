require 'formula'

class TmeBroker < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'

  def patches
    DATA
  end

  def install
    # Create library folder first to force linking JAR files.
    mkdir_p "#{HOMEBREW_PREFIX}/lib/tme"

    system "make", "--directory=src/broker", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme", "install"

    chmod 0400, "#{prefix}/etc/tme/broker/jmxremote.password", :verbose => true

    # No need to have init.d scripts.
    remove_dir "#{prefix}/etc/init.d"
    # Can't have install/remove scripts since they depends on init.d script.
    remove     "#{bin}/install_tme-broker.sh"
    remove     "#{bin}/remove_tme-broker.sh"
    # That's skip monit configuration, too.
    remove     "#{prefix}/etc/tme/broker/tme-broker.monit"
  end
end

__END__
diff --git a/src/broker/bin/broker.sh b/src/broker/bin/broker.sh
index e7c1068..83a9292 100755
--- a/src/broker/bin/broker.sh
+++ b/src/broker/bin/broker.sh
@@ -1,19 +1,23 @@
 #!/bin/bash
 
-source /opt/trend/tme/conf/common/common-env.sh
+source HOMEBREW_PREFIX/etc/tme/common/common-env.sh
 
-MEMORY=`sed -e '/imq\.system\.max_size/!d ; s/.*=//g' /opt/trend/tme/conf/broker/config.properties`
+MEMORY=`sed -e '/imq\.system\.max_size/!d ; s/.*=//g' HOMEBREW_PREFIX/etc/tme/broker/config.properties`
 
-CLASSPATH="$CLASSPATH:/opt/trend/tme/conf/broker"
-CLASSPATH="$CLASSPATH:/opt/trend/tme/lib/*"
+CLASSPATH="$CLASSPATH:HOMEBREW_PREFIX/etc/tme/broker"
+CLASSPATH="$CLASSPATH:HOMEBREW_PREFIX/lib/tme/*"
 CLASSPATH=`echo "$CLASSPATH" | sed -e 's/^://'` # remove leading colon
 
 JVM_ARGS="$JVM_ARGS -server -Xmx$MEMORY -Xms$MEMORY"
 JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.port=5566"
 JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.authenticate=true"
 JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.ssl=false"
-JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.password.file=/opt/trend/tme/conf/broker/jmxremote.password"
-JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.access.file=/opt/trend/tme/conf/broker/jmxremote.access"
+JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.password.file=HOMEBREW_PREFIX/etc/tme/broker/jmxremote.password"
+JVM_ARGS="$JVM_ARGS -Dcom.sun.management.jmxremote.access.file=HOMEBREW_PREFIX/etc/tme/broker/jmxremote.access"
+# Overwrite default properties.
+JVM_ARGS="$JVM_ARGS -Dcom.trendmicro.tme.broker.mqhome=HOMEBREW_PREFIX"
+JVM_ARGS="$JVM_ARGS -Dcom.trendmicro.tme.broker.mqvar=HOMEBREW_PREFIX/var/lib/tme/broker"
+JVM_ARGS="$JVM_ARGS -Dcom.trendmicro.tme.broker.config=HOMEBREW_PREFIX/etc/tme/broker/config.properties"
 
 if [ "$1" == "daemon" ]
 then
diff --git a/src/broker/bin/imqcmd b/src/broker/bin/imqcmd
index 2ca797c..21aec36 100755
--- a/src/broker/bin/imqcmd
+++ b/src/broker/bin/imqcmd
@@ -74,7 +74,7 @@ _classes=$imq_sharelibimq_home/imqadmin.jar:$imq_sharelib_home/fscontext.jar
 
 # Default external JARs
 if [ ! -z "$imq_ext_jars" ]; then
-    _classes='/opt/trend/tme/lib/*':$imq_ext_jars
+    _classes='HOMEBREW_PREFIX/lib/tme/*':$imq_ext_jars
 fi
 
 _mainclass=com.sun.messaging.jmq.admin.apps.broker.BrokerCmd
@@ -88,4 +88,4 @@ LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$imq_libhome; export LD_LIBRARY_PATH
 fi
 
 
-"$imq_javahome/bin/java" -cp '/opt/trend/tme/lib/*' $jvm_args $_mainclass "$@"
+"$imq_javahome/bin/java" -cp 'HOMEBREW_PREFIX/lib/tme/*' $jvm_args $_mainclass "$@"
diff --git a/src/broker/conf/broker/config.properties b/src/broker/conf/broker/config.properties
index f56ab02..8123391 100644
--- a/src/broker/conf/broker/config.properties
+++ b/src/broker/conf/broker/config.properties
@@ -36,6 +36,6 @@ imq.jmx.connector.jmxrmi.port=5567
 imq.log.level=ERROR
 imq.log.console.stream=OUT
 imq.log.console.output=NONE
-imq.log.file.dirpath=/var/log/tme
+imq.log.file.dirpath=HOMEBREW_PREFIX/var/log/tme
 imq.log.file.filename=broker-openmq.log
 imq.log.file.output=ALL
diff --git a/src/broker/conf/broker/logback.xml b/src/broker/conf/broker/logback.xml
index f31c6a3..c527736 100644
--- a/src/broker/conf/broker/logback.xml
+++ b/src/broker/conf/broker/logback.xml
@@ -1,11 +1,11 @@
 <configuration>
   <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
-    <file>/var/log/tme/broker.log</file>
+    <file>HOMEBREW_PREFIX/var/log/tme/broker.log</file>
     <encoder>
       <pattern>%date %level [%thread] %logger{10} [%file:%line] %msg%n</pattern>
     </encoder>
     <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
-    	<fileNamePattern>/var/log/tme/broker.log.%d{yyyy-MM-dd}.%i</fileNamePattern>
+    	<fileNamePattern>HOMEBREW_PREFIX/var/log/tme/broker.log.%d{yyyy-MM-dd}.%i</fileNamePattern>
     	<maxHistory>10</maxHistory>
     	<timeBasedFileNamingAndTriggeringPolicy
             class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
diff --git a/src/broker/conf/broker/tme-broker.monit b/src/broker/conf/broker/tme-broker.monit
index 8451f5e..3ce0e40 100644
--- a/src/broker/conf/broker/tme-broker.monit
+++ b/src/broker/conf/broker/tme-broker.monit
@@ -1,5 +1,5 @@
 set daemon 20
 check process tme-broker
-   with pidfile "/var/run/tme/tme-broker.pid"
-   start program = "/etc/init.d/tme-broker start"
-   stop program = "/etc/init.d/tme-broker stop"
+   with pidfile "HOMEBREW_PREFIX/var/run/tme/tme-broker.pid"
+   start program = "HOMEBREW_PREFIX/etc/init.d/tme-broker start"
+   stop program = "HOMEBREW_PREFIX/etc/init.d/tme-broker stop"


