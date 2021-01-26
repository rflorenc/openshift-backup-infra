.PHONY: default install test venv venv-clean clean

WORKDIR?=.
PY?=python3
VENVDIR?=$(WORKDIR)/venv
VENV=$(VENVDIR)/bin

.EXPORT_ALL_VARIABLES:

default: install

install: venv
        export BACKUP_INFRA=true; $(VENV)/ansible-playbook site.yaml

clean: venv-clean

# Prepare a Python3 virtualenv
venv:
	$(PY) -m venv --prompt backup $(VENVDIR)
	$(VENV)/pip install -Ur requirements.txt pip

venv-clean:
	rm -fr $(VENVDIR)
