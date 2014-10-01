# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit kadu

DESCRIPTION="Adds history of sent messages to Kadu chat window"
HOMEPAGE="http://www.ultr.pl/kadu/"
SRC_URI="http://download.kadu.im/external-plugins/stable/${MOD_NAME}-${PV/_p/-}.tar.bz2"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-qt/qtgui-4.8.0:4
	>=net-im/kadu-core-1.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MOD_NAME}"
