FROM fedora:34

RUN \
	yum update -y

RUN \
	yum install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm && \
	yum install -y dosbox ffmpeg curl

RUN \
	yum install -y x11vnc xorg-x11-server-Xvfb zip xdotool nodejs

RUN \
	yum install -y alsa-lib alsa-plugins-pulseaudio
