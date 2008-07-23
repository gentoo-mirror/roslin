#!/sbin/runscript
# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

depend() {
	need dbus
	[ "${CDEMUD_BACKEND}" == alsa ] && need alsasound
}

start() {
	ebegin "Loading CDemu userspace daemon"
	if ! grep -qw vhba /proc/modules; then
		/sbin/modprobe vhba || eerror $? "Error loading vhba module"
	fi
	i=0; until [ -c /dev/vhba_ctl ]; do ((i++<=10)) || break; sleep 1; done
	if [ "${CDEMUD_BACKEND}"x == x ]; then
		CDEMUD_ARGS="-a null"
	else
		CDEMUD_ARGS="-a ${CDEMUD_BACKEND}"
	fi
	CDEMUD_ARGS="-d -c /dev/vhba_ctl -n ${CDEMUD_DEVICES:-1} ${CDEMUD_ARGS}"
	start-stop-daemon --quiet --start --exec /usr/bin/cdemud -- ${CDEMUD_ARGS}
	eend $?
}

stop() {
	ebegin "Stopping CDemu userspace daemon"
	/usr/bin/cdemud -k; status=$?
	/sbin/rmmod vhba || eerror $? "Error unloading vhba module"
	eend "${status}"
}
