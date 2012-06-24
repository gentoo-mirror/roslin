# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Mathematical TeX formula support in Kadu chats"
HOMEPAGE="http://www.kadu.net/w/Mime_tex"
SRC_URI="http://download.kadu.im/external-plugins/${NAME}/${NAME}-${PV/_p/-}.tar.bz2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.12.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"
