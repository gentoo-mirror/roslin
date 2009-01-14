# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_PV="${PV//./}"

inherit games

DESCRIPTION="iDeaS is a closed-source Nintendo DS emulator using GTK+"
HOMEPAGE="http://www.ideasemu.org/"
SRC_URI="http://www.ideasemu.org/ideas_scripts/resolve_link.php?link=ideas${MY_PV}.tar.bz2&type=2 -> ideas-${PV}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RESTRICT="mirror strip"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/ideas"

DEPEND="app-arch/unzip"
RDEPEND=">=x11-libs/gtk+-2
		virtual/opengl"

src_install() {
	local dir="${GAMES_PREFIX_OPT}"/${PN}

	insinto "${dir}"
	doins -r ideas PlugIn || die "doins failed"
	fperms a+x "${dir}/ideas"
	games_make_wrapper ideas ./ideas "${dir}"
	dodoc readme.txt
	prepgamesdirs
}

