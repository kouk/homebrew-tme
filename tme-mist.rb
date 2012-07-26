require 'formula'

class TmeMist < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'

  def install
    # Create library folder first to force linking JAR files.
    mkdir_p "#{HOMEBREW_PREFIX}/lib/tme"

    system "make", "--directory=src/mist", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme", "install"

    # Executables don't have to put in $BUILD_PREFIX/usr/bin since homebrew
    # will help create symlinks in #{HOMEBREW_PREFIX}/bin.
    mv "#{prefix}/usr/bin/mist-line-gen",  "#{prefix}/bin/"
    mv "#{prefix}/usr/bin/tme-console",    "#{prefix}/bin/"
    remove_dir "#{prefix}/usr/bin"
    remove_dir "#{prefix}/usr"
    # Both common and mist modules of TME will install junit-3.8.1.jar.
    # This is OK for TME since it use `cp -rf` when installing.
    # But in Homebrew the final linking will fail due to existing link.
    # Since they are same JAR anyway, we'll simply delete it here.
    rm_f "#{prefix}/lib/tme/junit-3.8.1.jar"

    # No need to have init.d scripts.
    remove_dir "#{prefix}/etc/init.d"
  end
end



