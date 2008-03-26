# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games flag-o-matic

MY_PV=${PV/0./0}
MY_PV=${MY_PV/./u}
MY_P=${PN}${MY_PV}

DESCRIPTION="Multiple Arcade Machine Emulator (SDL)"
HOMEPAGE="http://rbelmont.mameworld.info/?page_id=163"
SRC_URI="${MY_P}.zip"

# Same as xmame. Should it be renamed to MAME?
LICENSE="XMAME"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="minimal debug"

DEPEND=">=media-libs/libsdl-1.2.10
        sys-libs/zlib
        dev-libs/expat
        debug? (
            >gnome-base/gconf-2
            >=x11-libs/gtk+-2 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
RESTRICT="fetch strip"

pkg_nofetch() {
	einfo "Please download ${SRC_URI}"
	einfo "from ${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

# Function to disable a makefile option
disable_feature() {
	sed -i \
		-e "/$1.*=/s:^:# :" \
		"${S}"/makefile
}

# Function to enable a makefile option
enable_feature() {
	sed -i \
		-e "/^#.*$1.*=/s:^# ::"  \
		"${S}"/makefile
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/paths-0.121.1.patch"
}

src_compile() {
	# Don't compile zlib and expat
	einfo "Disabling embedded libraries: zlib and expat"
	disable_feature BUILD_ZLIB
	disable_feature BUILD_EXPAT

	case ${ARCH} in
		amd64)  einfo "Enabling 64-bit support"
				enable_feature PTR64
				;;
	esac

	if use debug ; then
		enable_feature DEBUG
		enable_feature SYMBOLS
		enable_feature PROFILE
	fi

	local make_opts
	use minimal && make_opts="SUBTARGET=tiny"

	emake \
		NAME=${PN} \
		SUFFIX="" \
		${make_opts} \
		ARCHOPTS="${CFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dogamesbin ${PN} || die "dogamesbin ${PN} failed"

	# Follows xmame ebuild, avoiding collision on /usr/games/bin/jedutil
	exeinto $(games_get_libdir)/${PN}
	local f
	for f in chdman jedutil romcmp ; do
		doexe "${f}" || die "doexe ${f} failed"
	done

	dodoc docs/* *.txt

	prepgamesdirs

	ewarn "The default configuration directory for sdlmame on posix operating"
	ewarn "systems is now \$HOME/.sdlmame"
}
