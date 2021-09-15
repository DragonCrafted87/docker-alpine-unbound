#!/bin/bash

mkdir -p root/config

cat << EOF > root/config/domainlist.conf
https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt
https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt
https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt
https://v.firebog.net/hosts/Easyprivacy.txt
https://v.firebog.net/hosts/Prigent-Ads.txt
EOF

cat << EOF > root/config/hostfilelist.conf
https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.2o7Net/hosts
https://blocklistproject.github.io/Lists/tracking.txt
https://blocklistproject.github.io/Lists/malware.txt
https://blocklistproject.github.io/Lists/ads.txt
https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
EOF

docker build \
        --no-cache \
        --pull \
        --file Dockerfile \
        --tag unbound \
        .

MSYS_NO_PATHCONV=1 \
    docker run -it \
        --env TZ=America/Chicago \
        --publish 53:53 \
        unbound

rm -rf root/config
