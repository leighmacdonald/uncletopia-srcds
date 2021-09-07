LATEST = leighmacdonald/uncletopia-srcds:latest

all: image

image:
	docker build -t $(LATEST) .

publish: image
	docker push $(LATEST)

run:
	docker run -it $(LATEST)

shell: 
	docker run -it $(LATEST) bash
