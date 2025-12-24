.PHONY: landing

fmt:
	terraform fmt -recursive

deploy:
	cd terraform && terraform apply

landing:
	cd landing && hugo server -D

build:
	git submodule update --init --recursive
