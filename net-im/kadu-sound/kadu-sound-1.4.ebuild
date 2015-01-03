# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Sound support module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS=" ~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtgui-4.8.0:4
	~net-im/kadu-core-${PV}"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
