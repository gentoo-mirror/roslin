# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

MY_PV="${PV//./}"

inherit multilib games

DESCRIPTION="iDeaS is a closed-source Nintendo DS emulator using GTK+"
HOMEPAGE="http://ideasemu.biz/"
SRC_URI="http://ideasemu.biz/ideas_scripts/resolve_link.php?link=ideas${MY_PV}.tar.bz2 -> ideas${MY_PV}.tar.bz2
	alsa? ( http://ideasemu.biz/ideas_scripts/resolve_link.php?link=audplugin.zip -> audplugin.zip )
	mic? ( http://ideasemu.biz/ideas_scripts/resolve_link.php?link=micplugin.zip -> micplugin.zip )
	wifi? ( http://ideasemu.biz/ideas_scripts/resolve_link.php?link=wifiplugin.zip -> wifiplugin.zip )"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa mic wifi"

RESTRICT="mirror"
QA_EXECSTACK="${GAMES_PREFIX_OPT:1}/${PN}/ideas"
QA_PRESTRIPPED="${GAMES_PREFIX_OPT:1}/${PN}/ideas"

DEPEND="app-arch/unzip"

RDEPEND="amd64? ( app-emulation/emul-linux-x86-gtklibs
		>=app-emulation/emul-linux-x86-baselibs-20081109
		alsa? ( app-emulation/emul-linux-x86-soundlibs[alsa] ) )
	x86? ( >=x11-libs/gtk+-2
		alsa? ( media-libs/alsa-lib ) )
	virtual/opengl"

S="${WORKDIR}"

pkg_setup() {
	# x86 binary package, ABI=x86
	has_multilib_profile && ABI="x86"

	games_pkg_setup
}

src_install() {
	local dir="${GAMES_PREFIX_OPT}"/${PN}
	exeinto "${dir}"
	doexe ideas || die "doins failed"
	games_make_wrapper ideas ./ideas "${dir}"

	insinto "${dir}/PlugIn"
	use alsa && doins Linux/aud_alsa.so
	use mic && doins Linux/mic.so
	use wifi && doins Linux/wifi.so

	dodoc readme.txt
	prepgamesdirs
}
