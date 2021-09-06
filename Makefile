LATEST = leighmacdonald/uncletopia-srcds:latest

all: image

image:
	docker build -t $(LATEST) .

publish: image
	docker push $(LATEST)
 
run: image
	docker run \
		-v $(CURDIR)/tf-dedicated:/home/steam/tf-dedicated/ \
		-it \
		$(LATEST)