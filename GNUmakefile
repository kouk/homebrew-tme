.PHONY: all
all: help

.PHONY: help
help:
	@echo "Usage: make [ TARGET ... ]";
	@echo "";
	@echo "TARGET:";
	@echo "";
	@echo "  help                                - show this help message";
	@echo "  install                             - install ported tme components";
	@echo "  uninstall                           - uninstall all tme components";
	@echo "  install-component   NAME=component  - install specified tme component";
	@echo "  uninstall-component NAME=component  - uninstall specified tme component";
	@echo "  force-uninstall-all                 - force uninstall all tme components";
	@echo "";
	@echo "Default TARGET is 'help'.";
	@echo "";

.PHONY: install
install: uninstall
	@$(MAKE) install-component NAME=tme-common
	@$(MAKE) install-component NAME=tme-broker;
	@$(MAKE) install-component NAME=tme-mist;
	@$(MAKE) install-component NAME=tme-portal-collector;
	@$(MAKE) install-component NAME=tme-mist-tools;
#	@$(MAKE) install-component NAME=tme-portal-web;
#	@$(MAKE) install-component NAME=tme-graph-editor;

.PHONY: uninstall
uninstall:
#	@$(MAKE) uninstall-component NAME=tme-graph-editor;
#	@$(MAKE) uninstall-component NAME=tme-portal-web;
	@$(MAKE) uninstall-component NAME=tme-mist-tools;
	@$(MAKE) uninstall-component NAME=tme-portal-collector;
	@$(MAKE) uninstall-component NAME=tme-mist;
	@$(MAKE) uninstall-component NAME=tme-broker;
	@$(MAKE) uninstall-component NAME=tme-common

.PHONY: force-uninstall-all
force-uninstall-all:
	brew list | grep tme- | xargs -n1 -t brew uninstall --force;

.PHONY: install-component
install-component:
	@echo "--------------------------------------------------------";
	@echo "Installing $(NAME)";
	@echo "--------------------------------------------------------";
	brew install -vd --HEAD $(NAME);

.PHONY: uninstall-component
uninstall-component:
	@echo "--------------------------------------------------------";
	@echo "Uninstalling $(NAME)";
	@echo "--------------------------------------------------------";
	brew list | grep $(NAME) | xargs -n1 -t brew uninstall;

