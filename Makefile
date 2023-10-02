USER := $(shell jq -r .user env.json)
EXECUTION_PATH := $(shell jq -r .executionPath env.json)

convert-json:
	npx json5 env.json5 | jq . > env.json

clone-kubespray:
	git clone https://github.com/kubernetes-sigs/kubespray.git --recurse-submodule

copy-inventory:
	cp -rfp $(EXECUTION_PATH)/inventory/sample $(EXECUTION_PATH)/inventory/mycluster

SSH_KEY_NAME := $(shell jq -r .sshKeyName env.json)

execute: convert-json
	ansible-playbook -i $(EXECUTION_PATH)/inventory/mycluster/hosts.yml \
		--private-key="~/.ssh/$(EXECUTION_PATH)" \
		--become \
		--become-user=root \
		$(EXECUTION_PATH)/cluster.yml \
		-u $(USER) \
		-kK

execute-no-cache: convert-json
	ansible-playbook -i $(EXECUTION_PATH)/inventory/mycluster/hosts.yml \
		--become \
		--become-user=root \
		--flush-cache \
		$(EXECUTION_PATH)/cluster.yml \
		-u $(USER) \
		-kK

scale: convert-json
	ansible-playbook -i $(EXECUTION_PATH)/inventory/mycluster/hosts.yml \
		--private-key="~/.ssh/$(EXECUTION_PATH)" \
		--become \
		--become-user=root \
		$(EXECUTION_PATH)/scale.yml -b -v \
		-u $(USER) \
		-kK

reset: convert-json
	ansible-playbook -i $(EXECUTION_PATH)/inventory/mycluster/hosts.yml \
		--private-key="~/.ssh/$(EXECUTION_PATH)" \
		--become \
		--become-user=root \
		--flush-cache \
		$(EXECUTION_PATH)/reset.yml \
		-u $(USER) \
		-kK

setup: convert-json
	ansible-playbook -i $(EXECUTION_PATH)/inventory/mycluster/hosts.yml \
		--private-key="~/.ssh/$(EXECUTION_PATH)" \
		--become \
		--become-user=root \
		update.yml \
		--ask-pass \
		--ask-become-pass \
		-u $(USER)

# ------------------------ vagrant ------------------------

generate-vagrant-key:
	ssh-keygen -t rsa -f vagrant

#setup:
#	ansible-playbook -i ./inventory \
#		test.yml \
#		--ask-pass \
#		--ask-become-pass \
#		-u $(USER)
