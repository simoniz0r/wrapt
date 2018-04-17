PREFIX ?= /usr
SYSCONFDIR ?= /etc

all:
	@echo Run \'make install\' to install wrapt.

install:
	@echo 'Installing binary...'
	@mkdir -p $(DESTDIR)$(PREFIX)/bin
	@cp -p wrapt.sh $(DESTDIR)$(PREFIX)/bin/wrapt
	
install-bash:
	@echo 'Installing bash completion script...'
	@mkdir -p $(DESTDIR)$(SYSCONFDIR)/bash_completion.d
	@cp -p bash-completion.sh $(DESTDIR)$(SYSCONFDIR)/bash_completion.d/wrapt.sh
	
install-zsh:
	@echo 'Installing zsh completion script...'
	@mkdir -p $(DESTDIR)$(PREFIX)/share/zsh/site-functions
	@cp -p zsh-completion.sh $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_wrapt

uninstall:
	@echo 'Removing files...'
	@rm -rf $(DESTDIR)$(PREFIX)/bin/wrapt
	@rm -rf $(DESTDIR)$(PREFIX)/share/zsh/site-functions/_wrapt
	@rm -rf $(DESTDIR)$(SYSCONFDIR)/bash_completion.d/wrapt.sh
