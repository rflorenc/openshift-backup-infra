.PHONY: default install test venv venv-clean clean pull

WORKDIR?=.
PY?=python3
VENVDIR?=$(WORKDIR)/venv
VENV=$(VENVDIR)/bin

.EXPORT_ALL_VARIABLES:

default: install

guard-install:
	# Check if we are logged-in to an OpenShift cluster.
	oc whoami || (echo "oc whoami failed $$?"; exit 1)
	# Check if STORAGE_CLASS env var is defined.
	test -n "$(STORAGE_CLASS)"

install: guard-install venv
	$(VENV)/ansible-playbook site.yaml -v --extra-vars "storage_class=${STORAGE_CLASS}"

guard-uninstall:
	# Check if we are logged-in to an OpenShift cluster.
	oc whoami || (echo "oc whoami failed $$?"; exit 1)

uninstall: guard-uninstall venv
	$(VENV)/ansible-playbook site.yaml -v --tags "uninstall"

clean: venv-clean

# Prepare a Python3 virtualenv.
venv:
	$(PY) -m venv --prompt backup $(VENVDIR)
	$(VENV)/pip install -Ur requirements.txt pip

venv-clean:
	rm -fr $(VENVDIR)

pull:
	for img in `awk '{print $$2}' $(WORKDIR)/hack/docker_images.list`;do docker pull $$img;done
