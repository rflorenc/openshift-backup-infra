.PHONY: default install test venv venv-clean clean pull

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

pull:
	for img in `awk '{print $$2}' $(WORKDIR)/docker_images.list`;do docker pull $$img;done
