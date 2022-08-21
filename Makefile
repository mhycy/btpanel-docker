build:
	docker build -f Dockerfile.centos -t local/btpanel .

copy:
	mkdir $(shell pwd)/btpanel && docker run --rm -v $(shell pwd)/btpanel:/btpanel local/btpanel cp -R /www /btpanel

rm-image:
	docker image rm local/btpanel