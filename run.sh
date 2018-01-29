docker run -it -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -v /dev/snd:/dev/snd --device=/dev/dri:/dev/dri \
	   -v /home/robert/docker/shared:/home/robert/shared \
	   --privileged \
	   -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
           --security-opt seccomp=unconfined --tmpfs /run --tmpfs /run/lock \
	   --name=$1 \
	   rjrx23/docker-gui-minimal

