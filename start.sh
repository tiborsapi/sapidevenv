docker build -t dev-env:gui .
docker stop dev-env-gui
docker rm dev-env-gui
docker run -it --privileged \
	--env="DISPLAY=$DISPLAY" \
	--env="XAUTHORITY=$XAUTHORITY" \
	--volume="$XAUTHORITY:$XAUTHORITY" \
	--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
	--volume="$HOME/work:/home/ubuntu/work"  \
	--user $(id -u):$(id -g) \
	--name dev-env-gui \
	dev-env:gui

