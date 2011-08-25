# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Mathematical TeX formula support in Kadu chats"
HOMEPAGE="http://www.kadu.net/w/Mime_tex"
SRC_URI="http://kadu.net/~weagle/${NAME}-${PV}.tar.bz2"
KEYWORDS=""
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.10.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"
