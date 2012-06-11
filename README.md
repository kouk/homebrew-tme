Homebrew Formulae for TME
=========================

This repository contains *unofficial* [Homebrew][brew] formulae for installing
[TME][tme] on Mac OS X.

Installation
------------

Just `brew tap trendmicro/tme` and then `brew install --HEAD <formula>`.

If the formula conflicts with one in `mxcl/master`, you can
`brew install trendmicro/tme/<formula>`.

You can also install via URL:

	brew install --HEAD https://raw.github.com/trendmicro/homebrew-tme/master/<formula>.rb

### TME Components

Currently, TME components must be installed one by one using the following
commands:

	brew install --HEAD tme-common
	brew install --HEAD tme-broker
	brew install --HEAD tme-mist
	brew install --HEAD tme-portal-collector
	brew install --HEAD tme-mist-tools
	brew install --HEAD tme-portal-web
	brew install --HEAD tme-graph-editor

We wish to allow installing all of them at once by `brew install --HEAD tme`,
if we confirm that Homebrew support *meta formula*, a formula installs nothing
itself but brings all components through dependencies.

### Heads Only

Currently, homebrew-tme only support head-only builds since TME has no stable
version for Mac, yet. You must add `--HEAD` option when running `brew install`.

Considerations
--------------

Running TME on Mac OS X is usually for development or demonstration. The
formulae will alter TME to adapt the non-production environment.

### Running TME in User Account Instead

TME daemons are designed to run in the special system account `TME`. This
contradict to Homebrew's design, which says [sudo is bad][badsudo].  Therefore,
these formulae will not create the special system account and will expect/help
running TME using *your* own account directly.

### Separate PREFIX for each component

To simplify operation tasks, all TME components are by default installed to
same directory, `/opt/trend/tme`. On the contrary, Homebrew will install each
package to individual and isolated folder called *Keg*. These formulae will
configure *Keg* as the installation `PREFIX` during package building. Since we
still wish to separate TME components, they will no longer reside in same
`PREFIX`.

### Will not use launchd to manage daemons

On Mac [launchd][launchd](8) is used to manage services, which is essentially
a replacement for `init.d` scripts on Linux. However, since we usually run TME
on Mac for development/demonstration purposes only, there is no need to launch
TME daemons everytime. Instead, these formulae will provide easy commands to
initiate/terminate TME environment.

### Monitoring is removed for simplicity

TME daemons are monitored by [monit][monit]. However, since we do not plan to
run TME on Mac for production purpose, there is no need to do any monitoring.
Therefore, these formulae will remove monitoring supports to simplify the whole
thing.


[brew]: http://mxcl.github.com/homebrew/
[tme]:  	http://trendmicro.github.com/tme/
[badsudo]: https://github.com/mxcl/homebrew/wiki/FAQ#wiki-sudo
[launchd]: http://en.wikipedia.org/wiki/Launchd
[monit]:   http://mmonit.com/monit/
