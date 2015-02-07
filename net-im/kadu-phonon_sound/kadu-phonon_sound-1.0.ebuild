# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Phonon sound output module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtgui-4.8.0:4
	~net-im/kadu-core-${PV}
	|| ( media-libs/phonon dev-qt/qtphonon:4 )
	~net-im/kadu-sound-${PV}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"