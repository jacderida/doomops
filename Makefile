SHELL := /bin/bash

odamex-server-aws:
	( \
		cd terraform/aws; \
		rm -rf .terraform; \
		terraform init; \
		terraform workspace select dev; \
		terraform apply -auto-approve; \
	)

clean-odamex-server-aws:
	cd terraform/aws && terraform destroy -auto-approve
