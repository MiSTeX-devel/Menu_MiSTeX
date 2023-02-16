#!/bin/bash
quartus_pgm -m jtag -c USB-Blaster -o "p;${1}@1"
