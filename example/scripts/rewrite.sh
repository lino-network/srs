#!/usr/bin/env bash

# kill all previous processes.
sudo kill $(ps aux | grep '[s]rs' | awk '{print $2}')

sleep 2

cd ../../
cd ../
rm -rf srs-edge
cp -r srs srs-edge
cd srs-edge/trunk
sudo ./objs/srs -c ../example/conf/test-edge.conf

sleep 2

cd ../../
rm -rf srs-ingest
cp -r srs srs-ingest
cd srs-ingest/trunk
sudo ./objs/srs -c ../example/conf/test-ingest.conf

sleep 2

ps aux | grep srs
