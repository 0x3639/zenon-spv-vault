SRC ?= /tmp/zenon-developer-commons

.PHONY: help extract submodule-update check tree

help:
	@echo "Targets:"
	@echo "  make extract [SRC=...]   Re-derive spec/ from a local clone of zenon-developer-commons"
	@echo "                           (default SRC: /tmp/zenon-developer-commons)"
	@echo "  make submodule-update    Fast-forward reference/go-zenon and rewrite the pin in reference/CLAUDE.md"
	@echo "  make check               Run vault invariant checks"
	@echo "  make tree                Print depth-2 tree of the vault"

extract:
	bash scripts/extract_pdfs.sh $(SRC)

submodule-update:
	bash scripts/refresh_submodule.sh

check:
	python3 scripts/check_vault.py $(SRC)

tree:
	tree -L 2 -I 'go-zenon|.git'
