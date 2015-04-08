#!/bin/sh

#This script is to able to comply with the inane COMP115 submission requirements

#Compile images into source code
rm -rf /tmp/processing
cd CompileGraphics
processing-java --output=/tmp/processing/ --run --sketch=../CompileGraphics
cd ..

#Combine all source code
mkdir -p ass2
cat wth.pde main.pde actor.pde ship.pde wormhole.pde blackhole.pde background.pde compiledGraphics.pde > ass2/ass2.pde
