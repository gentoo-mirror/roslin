# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils games

DESCRIPTION="The objective is simply to destroy all the green hexagonal tiles"
HOMEPAGE="http://www.aceinternet.co.uk/~mokona/"
SRC_URI="mirror://debian/pool/main/h/${PN}/${P/p-/p_}.orig.tar.gz"
#	http://archive.ubuntu.com/ubuntu/pool/universe/h/hex-a-hop/hex-a-hop_0.0.20070315-2.diff.gz"
#	mirror://debian/pool/main/h/${PN}/${P/p-/p_}-${PATCH_LEVEL}.diff.gz

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-pango
	sys-libs/libunwind"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}
dir=${GAMES_DATADIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s|= Hex-a-hop|= hex-a-hop|" Makefile || die "sed"

#	sed -i -e "s|hex-a-hop-0.0.20070315/||" \
#		${WORKDIR}/${P/p-/p_}-${PATCH_LEVEL}.diff
#	epatch ${WORKDIR}/${P/p-/p_}-${PATCH_LEVEL}.diff
#	epatch ${WORKDIR}/hex-a-hop_0.0.20070315-2.diff

	epatch "${FILESDIR}"/endianess.patch

#	epatch ${FILESDIR}/minimal-sdl-init.patch

	epatch "${FILESDIR}"/proper_directories.patch

#	epatch ${FILESDIR}/gettext_i18n.patch
#	epatch ${FILESDIR}/patch-hex-a-hop-better-than-par.diff
#	epatch ${FILESDIR}/typos.patch
#	epatch ${FILESDIR}/compiler_warnings.patch
#	epatch ${FILESDIR}/pango_fonts.patch
#	epatch ${FILESDIR}/remove_old_font_handling.patch
#	epatch ${FILESDIR}/array_subscripts_warning.patch
#	epatch ${FILESDIR}/i18n_increase_array_sizes.patch
#	epatch ${FILESDIR}/mouse_cursor_without_font.patch
#	epatch ${FILESDIR}/misc_errors.patch
#	epatch ${FILESDIR}/reduce_cpu_usage.patch
#	epatch ${FILESDIR}/mouse-wheel-support.patch
#	epatch ${FILESDIR}/segfault_443822.patch
}

src_install() {
	insinto "$dir"
	doins -r graphics *.dat

	exeinto "$dir"
	doexe ${PN}

	games_make_wrapper ${PN} "./${PN}" "${GAMES_DATADIR}/${PN}"
}
