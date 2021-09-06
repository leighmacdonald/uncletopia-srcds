LATEST = leighmacdonald/uncletopia-srcds:latest

all: image

image:
	docker build -t $(LATEST) .

publish: image
	docker push $(LATEST)

run: image
	docker run -v $(CURDIR)/tf2data:/home/steam/tf-dedicated/ -it $(LATEST)

shell: 
	docker run -v $(CURDIR)/tf2data:/home/steam/tf-dedicated/ -it $(LATEST) bash
