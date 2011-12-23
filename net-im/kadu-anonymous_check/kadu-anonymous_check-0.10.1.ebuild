# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu

DESCRIPTION="Automatic sender lookup module for Kadu"
HOMEPAGE="http://www.kadu.net/w/Anonymous_check"
SRC_URI="http://grubelek.pl/mziab/${NAME}-${PV}.tar.bz2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/qt-gui-4.7.0
	>=net-im/kadu-core-0.10.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${NAME}"
