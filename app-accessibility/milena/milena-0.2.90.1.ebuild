# Copyright 1999-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A TTS system for raw Polish texts"
HOMEPAGE="http://milena.polip.com/"
SRC_URI="http://polip.com/files/${P}.tar.gz"

LICENSE="GPL-3 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-accessibility/mbrola[l10n_pl]"
RDEPEND="${DEPEND}
	media-sound/sox"

src_prepare() {
	epatch "${FILESDIR}/${PN}-makefile.patch"
}
