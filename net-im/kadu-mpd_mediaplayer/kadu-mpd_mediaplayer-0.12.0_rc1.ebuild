# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="mpd mediaplayer module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	~net-im/kadu-core-${PV}
	media-libs/libmpdclient
	~net-im/kadu-mediaplayer-${PV}"
RDEPEND="${DEPEND}"
