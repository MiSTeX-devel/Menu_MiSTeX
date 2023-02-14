#!/bin/bash
xhost +
time docker run -it --rm -v $(pwd):/build  --net=host --ipc=host -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --env="QT_X11_NO_MITSHM=1" raetro/quartus:17.0 quartus *.qpf
