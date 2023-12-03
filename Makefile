.PHONY: volumes image container build

volumeName = postgres-playground-data
tag = postgres-playground

volumes:
	docker volume create --name=$(volumeName)

image:
	docker build -t $(tag) .

build: volumes image

container:
	docker run -it --rm -v $(volumeName):/var/lib/postgresql/data $(tag)

containerd:
	docker run -it --rm -d -v $(volumeName):/var/lib/postgresql/data $(tag)
