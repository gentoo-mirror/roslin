# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: overlay lapis ebuild deposu Exp $

inherit eutils python

DESCRIPTION="a GUI for youtube-dl and others."
HOMEPAGE="http://bashterritory.com/pytube"
#SRC_URI="http://www.bashterritory.com/${PN}/releases/${P}.tar.bz2"    
SRC_URI="http://files.myopera.com/lazy_bum/tmp/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
	>=dev-python/pygtk-2.6.0
	media-video/mplayer
	media-video/ffmpeg2theora
	media-video/ffmpeg
	media-sound/sox
	dev-python/celementtree
	>=dev-python/gdata-1.1.1"

RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use media-video/mplayer encode ; then
		die "media-video/mplayer needs to be built with USE=\"encode\""
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "s/\.\/pytube/python pytube/" pytube || die "sed failed"
}

src_install() {
	dobin "${PN}"
	doicon "${PN}".png

	insinto /usr/share/applications
	doins "${PN}".desktop

	insinto /usr/share/pytube
	doins -r stream2hdd
	doins *
}
