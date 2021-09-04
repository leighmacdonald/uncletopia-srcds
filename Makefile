all: image
image:
	docker build -t leighmacdonald/uncletopia-srcds:latest .

publish: image
	docker push leighmacdonald/uncletopia-srcds:latest
