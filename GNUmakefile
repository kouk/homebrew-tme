.PHONY: all
all: install

.PHONY: install
install: uninstall
	brew install -vd --HEAD tme-common;
	brew install -vd --HEAD tme-broker;
	brew install -vd --HEAD tme-mist;
	brew install -vd --HEAD tme-portal-collector;
	brew install -vd --HEAD tme-mist-tools;
#	brew install -vd --HEAD tme-portal-web;
#	brew install -vd --HEAD tme-graph-editor;

.PHONY: uninstall
uninstall:
	brew list | grep tme- | xargs -n1 -t brew uninstall;


