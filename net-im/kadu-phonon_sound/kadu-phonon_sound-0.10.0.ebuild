# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Phonon sound output module for Kadu"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
	|| ( media-libs/phonon x11-libs/qt-phonon )
	~net-im/kadu-sound-${PV}"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

