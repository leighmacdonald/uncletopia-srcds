BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
TAGGED_IMAGE = leighmacdonald/uncletopia-srcds:$(BRANCH)

all: publish

rebuild:
	docker build -t $(TAGGED_IMAGE) --no-cache .

image:
	docker build -t $(TAGGED_IMAGE) .

publish: image
	docker push $(TAGGED_IMAGE)

run:
	docker run -it $(TAGGED_IMAGE)

shell: 
	docker run -it $(TAGGED_IMAGE) bash
