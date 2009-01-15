# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

MY_PV="${PV/_p/-src-gtk-}"

DESCRIPTION="A GTK+2 port of the Snes9x emulator"
HOMEPAGE="http://www.snes9x.com/phpbb2/viewtopic.php?t=3703"
SRC_URI="http://bearoso.googlepages.com/snes9x-${MY_PV}.tar.bz2"

LICENSE="as-is GPL-2 LGPL-2 GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="joystick +jma netplay opengl +xv +xrandr +zlib"

RESTRICT="mirror"

RDEPEND=">=x11-libs/gtk+-2.10
	>=media-libs/portaudio-19_pre
	joystick? ( >=media-libs/libsdl-1.2.12 )
	opengl? ( >=x11-libs/gtkglext-1.0 )
	xv? ( x11-libs/libXv )
	xrandr? ( x11-libs/libXrandr )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/snes9x-1.51-src/gtk"

src_configure() {
	egamesconf $(use_with opengl) \
		$(use_with joystick) \
		$(use_with xv) \
		$(use_with xrandr) \
		$(use_with netplay) \
		$(use_with zlib) \
		$(use_with jma jma-decomp) \
		$(use_with x86 assembler) \
		--datadir=/usr/share \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install \
	|| die "install failed"
	dodoc AUTHORS doc/README
	
	prepgamesdirs
}
