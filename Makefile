TERRAFORM_DIR := terraform
DIST_DIR := dist
ZIP := dist.zip
TMP_DIR := $(DIST_DIR)/tmp
PROJECT_NAME := wordvice

plan-tf:
	terraform plan -refresh=true -state=$(TERRAFORM_DIR)/terraform.tfstate $(TERRAFORM_DIR)/

apply-tf:
	terraform apply -refresh=true -state=$(TERRAFORM_DIR)/terraform.tfstate $(TERRAFORM_DIR)/

build-tf:
	downtoearth -c $(TERRAFORM_DIR)/downtoearth.json $(TERRAFORM_DIR)/api.tf

build-lambda: build-lambda-deps
	cp lambda_handler.py routes.py $(DIST_DIR)/
	rsync -rltvzP --exclude '*.pyc' --exclude '__pycache__' --exclude '.cache' wordvice $(DIST_DIR)/
	cd $(DIST_DIR) && zip -r $(ZIP) .
	@echo "Built at "$@

build-lambda-deps: ## build lambda dependencies
	mkdir -p $(DIST_DIR)
	mkdir -p $(TMP_DIR)
	pip install --install-option="--prefix=$(abspath $(TMP_DIR))" -r requirements.txt -I
	cp -r $(TMP_DIR)/lib*/*/site-packages/* $(DIST_DIR)
	rm -r $(TMP_DIR)

publish-production: build-lambda
	$(eval CODE_SHA_256=$(shell $(auth) aws lambda --region=us-east-1 update-function-code --function-name $(PROJECT_NAME)_root --zip-file fileb://dist/dist.zip | jq -r .CodeSha256))
	$(eval LPUB_VERSION=$(shell $(auth) aws lambda --region=us-east-1 publish-version --function-name $(PROJECT_NAME)_root --code-sha-256 $(CODE_SHA_256) | jq -r .Version))
	@$(auth) aws lambda --region=us-east-1 update-alias --function-name $(PROJECT_NAME)_root --name production --function-version $(LPUB_VERSION)
