require 'formula'

class TmeMist < Formula
  head 'https://github.com/trendmicro/tme.git', :branch => 'osx-lion'
  homepage 'http://trendmicro.github.com/tme/'
# md5 '1234567890ABCDEF1234567890ABCDEF'

# depends_on 'cmake'
# depends_on 'rvm'
  depends_on 'tme-common'

  def install
    system "make", "--directory=src/mist", "BUILD_PREFIX=#{prefix}", "INSTALLPATH=", "CONFPATH=etc/tme", "LIBPATH=lib/tme-mist", "install"

    # Executables don't have to put in $BUILD_PREFIX/usr/bin since homebrew
    # will help create symlinks in #{HOMEBREW_PREFIX}/bin.
    mv "#{prefix}/usr/bin/mist-line-gen",  "#{prefix}/bin/"
    mv "#{prefix}/usr/bin/tme-console",    "#{prefix}/bin/"
    remove_dir "#{prefix}/usr/bin"
    remove_dir "#{prefix}/usr"
  end
end



