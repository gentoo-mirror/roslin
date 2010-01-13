# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

MY_PV="${PV/_p/-src-gtk-}"

DESCRIPTION="A GTK+2 port of the Snes9x emulator"
HOMEPAGE="http://code.google.com/p/snes9x-gtk/"
SRC_URI="http://snes9x-gtk.googlecode.com/files/snes9x-${MY_PV}.tar.bz2"

LICENSE="as-is GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="joystick +jma netplay opengl +xv +xrandr +zlib"

RESTRICT="mirror"

RDEPEND=">=x11-libs/gtk+-2.10
	>=gnome-base/libglade-2.0
	>=media-libs/portaudio-19_pre
	joystick? ( >=media-libs/libsdl-1.2.12 )
	opengl? ( virtual/opengl )
	xv? ( x11-libs/libXv )
	xrandr? ( x11-libs/libXrandr )
	zlib? ( sys-libs/zlib )
	x11-misc/xdg-utils"
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

S="${WORKDIR}/snes9x-1.51-src/gtk"

src_prepare() {
	epatch "${FILESDIR}/${PN}-1.51_p75-no-exec-stack.patch"
}

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
