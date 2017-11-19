IMAGE=yen3/binfmt-register
VERSION=0.1

all:
	docker build -t ${IMAGE}:${VERSION} .
	docker build -t ${IMAGE}:latest .

push:
	docker tag ${IMAGE}:${VERSION} ${IMAGE}:${VERSION}
	docker tag ${IMAGE}:latest ${IMAGE}:latest
	docker push ${IMAGE}:${VERSION}
	docker push ${IMAGE}:latest

