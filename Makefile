docker_image:
	docker image ls | grep web_pred
docker_bash:
	docker run -it web_pred /bin/bash
docker_build:
	docker build -t web_pred .
