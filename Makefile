build:
	docker build -f Dockerfile.centos -t mhycy/baota .

copy:
	mkdir $(shell pwd)/baota && docker run --rm -v $(shell pwd)/baota:/baota mhycy/baota cp -R /www /baota

rm-image:
	docker image rm mhycy/baota