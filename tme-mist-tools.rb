require 'formula'

class TmeMistTools < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'
  depends_on 'tme-mist'

  def install
    system "make", "--directory=src/mist-tools", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme-mist-tools", "install"

    # Executables don't have to put in $BUILD_PREFIX/usr/bin since homebrew
    # will help create symlinks in #{HOMEBREW_PREFIX}/bin.
    mkdir "#{prefix}/bin"
    mv "#{prefix}/usr/bin/mist-decode",  "#{prefix}/bin/"
    mv "#{prefix}/usr/bin/mist-encode",  "#{prefix}/bin/"
    mv "#{prefix}/usr/bin/mist-session", "#{prefix}/bin/"
    mv "#{prefix}/usr/bin/mist-sink",    "#{prefix}/bin/"
    mv "#{prefix}/usr/bin/mist-source",  "#{prefix}/bin/"
    remove_dir "#{prefix}/usr/bin"
    remove_dir "#{prefix}/usr"
  end
end






