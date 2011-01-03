# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit gnome2 autotools games

DESCRIPTION="A simple MAME front-end for the GNOME Desktop Environment"
HOMEPAGE="http://mbarnes.github.com/gnome-video-arcade/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dbus gstreamer"

RDEPEND=">=x11-libs/gtk+-2.18.0
	>=x11-themes/gnome-icon-theme-2.18.0
	>=dev-db/sqlite-3.0.0
	>=x11-libs/libwnck-2.16
	gnome-base/gconf
	dbus? ( dev-libs/dbus-glib )
	gstreamer? ( >=media-libs/gst-plugins-base-0.10 )
	|| ( games-emulation/sdlmame games-emulation/xmame )
	dev-libs/libunique"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_unpack() {
	gnome2_src_unpack
	cd "${S}"

	# change search patch to include /usr/games/bin
	sed -e "s:/usr/games:${GAMES_BINDIR}:g" \
	    -i configure.ac || die "sed failed"

	eautoreconf
}

src_compile() {
	gnome2_src_compile \
	    --bindir="${GAMES_BINDIR}" \
	    $(use_with dbus) \
	    $(use_with gstreamer) \
	    || die "compile failed"
}

src_install() {
	gnome2_src_install || die "install failed"
	prepgamesdirs
}
