# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

MY_P="snes9x-${PV}-src"

DESCRIPTION="A GTK+2 port of the Snes9x emulator"
HOMEPAGE="http://code.google.com/p/snes9x-gtk/"
SRC_URI="http://snes9x-gtk.googlecode.com/files/${MY_P}.tar.bz2"

LICENSE="as-is GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa oss pulseaudio portaudio joystick +jma netplay opengl +xv +xrandr +zlib"

RESTRICT="mirror"

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2.0
	portaudio? ( >=media-libs/portaudio-19_pre )
	joystick? ( >=media-libs/libsdl-1.2.12 )
	opengl? ( virtual/opengl )
	xv? ( x11-libs/libXv )
	xrandr? ( x11-libs/libXrandr )
	zlib? ( sys-libs/zlib )
	x11-misc/xdg-utils
	alsa? ( media-libs/alsa-lib )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/${MY_P}/gtk"

src_configure() {
	egamesconf $(use_with opengl) \
		$(use_with joystick) \
		$(use_with xv) \
		$(use_with xrandr) \
		$(use_with netplay) \
		$(use_with zlib) \
		$(use_with jma jma-decomp) \
		$(use_with x86 assembler) \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with pulseaudio) \
		$(use_with portaudio) \
		--datadir=/usr/share \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install \
	    || die "install failed"
	dodoc AUTHORS doc/README

	prepgamesdirs
}
