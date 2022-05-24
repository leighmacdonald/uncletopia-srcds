BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
HASH := $(shell git rev-parse HEAD)
TAGGED_IMAGE = leighmacdonald/uncletopia-srcds:$(BRANCH)
LATEST_IMAGE = leighmacdonald/uncletopia-srcds:latest
all: image

tag_image:
	docker build -t $(TAGGED_IMAGE) .

tag_publish: tag_image
	docker push $(TAGGED_IMAGE)

tag_run:
	docker run -it $(TAGGED_IMAGE)

tag_shell:
	docker run -it $(TAGGED_IMAGE) bash

image:
	docker build -t $(LATEST_IMAGE) .

publish: image
	docker push $(LATEST_IMAGE)

run:
	docker run -it $(LATEST_IMAGE)

shell:
	docker run -it $(LATEST_IMAGE) bash
