from ubuntu:16.04

#########################################
# Install basic system management utils #
#########################################

ARG DEBIAN_FRONTEND=noninteractive
ARG USER=robert
ARG UID=1000
ENV container docker	
RUN apt update && \
	apt install -y --no-install-recommends apt-utils libterm-readline-gnu-perl sudo apt-utils nano curl software-properties-common \
	python-notify python-keybinder terminator nvidia-340 dbus dbus-x11 dbus-user-session gedit dialog \
	libcanberra-gtk3-module libcanberra-gtk-module pulseaudio chromium-browser firefox && \
	find /etc/systemd/system \
        	 /lib/systemd/system \
         	-path '*.wants/*' \
         	-not -name '*journald*' \
         	-not -name '*systemd-tmpfiles*' \
         	-not -name '*systemd-user-sessions*' \
	 	-not -name '*dbus*' \
	 	-not -name '*xpra*' \
	 	-not -name '*pul*' \
         	-exec rm \{} \; && \
	systemctl set-default multi-user.target && \
	adduser --uid ${UID} --gecos '' --disabled-password ${USER} && \
	adduser ${USER} sudo && \
	echo ${USER}' ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/${USER} && \
	sed -i -e 's/^'${USER}'\:\*\:/'${USER}'\:\:/g' /etc/shadow && \
	mkdir -p /home/${USER}/.config/terminator

##############################
# Start systemd as process 1 #
##############################

STOPSIGNAL SIGRTMIN+3

CMD ["/bin/bash", "-c", "exec /sbin/init --log-target=journal 3>&1"]
