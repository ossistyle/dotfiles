MAJOR?=0
MINOR?=1
VERSION=$(MAJOR).$(MINOR)

APP_NAME = "dotfiles"

DOCKERFILE = "Dockerfile"

IMAGE_NAME = "${APP_NAME}"
CUR_DIR = $(shell echo "${PWD}")

#################################
# Chezmoi target
#################################
.PHONY: init
init:
	chezmoi init --apply --source=${CUR_DIR}

.PHONY: update
update:
	chezmoi apply --verbose

.PHONY: watch
watch:
	DOTFILES_DEBUG=1 watchexec -- chezmoi apply --verbose

.PHONY: reset
reset:
	chezmoi state delete-bucket --bucket=scriptState
	chezmoi state delete-bucket --bucket=entryState

.PHONY: reset-config
reset-config:
	chezmoi init --data=false

.PHONY: doctor
doctor:
	chezmoi doctor


#################################
# Docker targets
#################################
.PHONY: clean-image
clean-image: version-check
	@echo "+ $@"
	@docker rmi ${IMAGE_NAME}:latest  || true
	@docker rmi ${IMAGE_NAME}:${VERSION}  || true

.PHONY: image
image: version-check
	@echo "+ $@"
	@docker build -t ${IMAGE_NAME}:${VERSION} -f ./${DOCKERFILE} --build-arg USERNAME="$$(whoami)" .
	@docker tag ${IMAGE_NAME}:${VERSION} ${IMAGE_NAME}:latest
	@echo 'Done.'
#	@docker images --format '{{.Repository}}:{{.Tag}}\t\t Built: {{.CreatedSince}}\t\tSize: {{.Size}}' | \ 
#		grep ${IMAGE_NAME}:${VERSION}

#################################
# test targets
#################################
.PHONY: test-install
test-install:
	@echo "+ $@"
	./scripts/run_install_test.sh

.PHONY: test-setup
test-setup:
	@echo "+ $@"
	./scripts/run_setup_test.sh

.PHONY: test-all
test-all: test-install
	@echo "+ $@"
	

.PHONY: test-container
test-container: image
	@echo "+ $@"
	@docker run \
			-it \
			--rm \
			-u $$(whoami) \
			-v "$$(pwd):/home/$$(whoami)/.local/share/chezmoi" \
			--name ${IMAGE_NAME}-test-container \
			--env DOTFILES_TEST_CONTAINER=1 \
			--env DOTFILES_DEBUG=1 \
			${IMAGE_NAME}:latest \
			# /bin/bash --login -c "./setup.sh && make test-all" \

#################################
# Utilities
#################################

.PHONY: version-check
version-check:
	@echo "+ $@"
	@if [ -z "${VERSION}" ]; then \
		echo "VERSION is not set" ; \
		false ; \
	else \
		echo "VERSION is ${VERSION}"; \
	fi