Homebrew Formula for TME
========================

This repository contains official [Homebrew][brew] formula for installing
[TME][tme] on Mac OS X.

Installing homebrew-tme Formula
-------------------------------

Just `brew tap jeffhung/tme` and then `brew install --HEAD <formula>`.

If the formula conflicts with one in `mxcl/master`, you can
`brew install jeffhung/tme/<formula>`.

You can also install via URL:

	brew install https://raw.github.com/jeffhung/homebrew-tme/master/<formula>.rb

Head Only
---------

Currently, homebrew-tme only support head-only builds. You must add `--HEAD`
option when running `brew install`.

[brew]: http://mxcl.github.com/homebrew/
[tme]:  http://trendmicro.github.com/tme/

