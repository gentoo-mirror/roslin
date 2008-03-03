# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games

DESCRIPTION="A 2d soccer game"
HOMEPAGE="http://tuxfootball.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa arts dga jack nls"

RDEPEND="media-libs/sdl-mixer
		media-libs/sdl-image
		media-libs/libsdl
		alsa? ( media-libs/alsa-lib )
		arts? ( kde-base/arts )
		dga? ( x11-libs/libXxf86dga )
		nls? ( virtual/libintl )
		jack? ( media-sound/jack-audio-connection-kit )"
DEPEND="dev-util/intltool
		sys-devel/gettext
		${RDEPEND}"

src_compile() {
	egamesconf \
		$(use_with alsa snd-alsa) \
		$(use_with arts snd-arts) \
		$(use_with jack snd-jack) \
		$(use_with oss snd-oss) \
		$(use_enable nls) \
		--with-gettext || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
	make_desktop_entry ${PN} Tuxfootball
	prepgamesdirs
}
