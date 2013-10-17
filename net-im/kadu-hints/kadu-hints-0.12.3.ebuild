# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Hint notification module for Kadu"
HOMEPAGE="http://kadu.im"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.7.0:4
	~net-im/kadu-core-${PV}"
RDEPEND="${DEPEND}"
