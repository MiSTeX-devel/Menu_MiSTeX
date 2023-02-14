#!/bin/bash
time docker run -it --rm -v $(pwd):/build raetro/quartus:17.0 quartus_sh --flow compile *.qpf
