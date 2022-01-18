plan:
	terraform.exe init
	terraform.exe plan --var-file ./varfile.tfvars


apply:
	terraform.exe apply --var-file ./varfile.tfvars

lint:
	docker run --rm -v $(pwd):/data -t wata727/tflint

qa:
	cd ./test
	go test -v infra_test.go