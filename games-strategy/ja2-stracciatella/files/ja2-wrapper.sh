#!/bin/sh

SGPDATADIR="/opt/ja2-stracciatella"
DIR="${HOME}/.ja2/"
CONF="ja2.ini"

if [ ! -d "${DIR}" ]; then
    echo "* Creating '${DIR}'"
    mkdir -p ${DIR}
fi

if [ ! -e "${DIR}/${CONF}" ]; then
    echo "* Creating '${CONF}'"
    echo "data_dir = $SGPDATADIR" > "${DIR}/${CONF}"
fi

exec "${SGPDATADIR}"/ja2 ${@}
