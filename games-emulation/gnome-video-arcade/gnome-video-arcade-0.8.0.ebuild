# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit gnome2 autotools games

DESCRIPTION="A simple MAME front-end for the GNOME Desktop Environment"
HOMEPAGE="http://mbarnes.github.com/gnome-video-arcade/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gstreamer wnck"

RDEPEND="x11-libs/gtk+:3
	x11-themes/gnome-icon-theme
	dev-db/sqlite:3
	gnome-base/gconf:2
	gnome-base/gsettings-desktop-schemas
	gstreamer? ( >=media-libs/gst-plugins-base-0.10 )
	|| ( games-emulation/sdlmame games-emulation/xmame )
	dev-libs/libunique:1
	wnck? ( >=x11-libs/libwnck-2.16 )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	app-text/gnome-doc-utils
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README"

src_prepare() {
	# change search patch to include /usr/games/bin
	sed -e "s:/usr/games:${GAMES_BINDIR}:g" \
	    -i configure.ac || die "sed failed"

	eautoreconf
}

src_configure() {
	gnome2_src_configure \
	    --bindir="${GAMES_BINDIR}" \
	    $(use_with gstreamer) \
		$(use_with wnck) \
		--disable-static \
	    || die "configure failed"
}

src_install() {
	gnome2_src_install || die "install failed"
	prepgamesdirs
}
