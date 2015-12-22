#!/bin/sh

if ! getent passwd ${SYNCTHING_USERID}; then
    echo "Creating new syncthing account with user ID ${SYNCTHING_USERID}"
    adduser -D -g "Syncthing Account" -u ${SYNCTHING_USERID} syncthing
fi

if [[ $(stat -c %u /Config) != ${SYNCTHING_USERID} ]]; then
    echo "/Config volume has incorrect ownership, fixing"
    chown -R ${SYNCTHING_USERID} /Config
fi

if [[ $(stat -c %u /Data) != ${SYNCTHING_USERID} ]]; then
    echo "/Data volume has incorrect ownership, fixing"
    chown -R ${SYNCTHING_USERID} /Data
fi

if [[ ! -f /Config/config.xml ]]; then
    echo "Config is not found, generating"
    /bin/gosu ${SYNCTHING_USERID} /bin/syncthing -generate="/Config"
    sed -i 's/id="default" path="[a-zA-Z0-9\/]*"/id="default" path="\/Data\/"/' /Config/config.xml
    sed -i 's/127\.0\.0\.1/0.0.0.0/' /Config/config.xml
fi

exec /bin/gosu ${SYNCTHING_USERID} /bin/syncthing -home "/Config" -no-browser $@
