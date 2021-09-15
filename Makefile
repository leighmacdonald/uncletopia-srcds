LAST_TAG_COMMIT = $(shell git rev-list --tags --max-count=1)
LAST_TAG = $(shell git describe --tags $(LAST_TAG_COMMIT) )
TAGGED_IMAGE = leighmacdonald/uncletopia-srcds:$(LAST_TAG)
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
