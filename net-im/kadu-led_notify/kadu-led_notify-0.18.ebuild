# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

SRC_URI="http://kadu.net/~blysk/led_notify-${PV}.tar.bz2"

inherit kadu

MOD_DEPEND=">=net-im/kadu-notify-${MIN_REQ}"
MOD_TYPE="ext"

inherit kadu-module

DESCRIPTION="Kadu module notifying user using keyboard leds"
HOMEPAGE="http://kadu.net/~blysk"
KEYWORDS="amd64 x86"
IUSE=""
