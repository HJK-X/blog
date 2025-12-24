.PHONY: landing

fmt:
	terraform fmt -recursive

apply:
	cd terraform && terraform apply

landing:
	cd landing && hugo server -D

build:
	git submodule update --init --recursive
	hugo
