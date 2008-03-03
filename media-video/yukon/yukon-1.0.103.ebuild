# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit toolchain-funcs multilib

RESTRICT="multilib-pkg-force"

DESCRIPTION="OpenGL video capturing framework"
HOMEPAGE="http://neopsis.com/projects/yukon"
SRC_URI="http://dbservice.com/ftpdir/tom/${PN}/trunk/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/seom"

src_unpack() {
	for ABI in $(get_install_abis); do
		unpack "${A}"
		mv "${P}" "${ABI}"
	done
}

src_compile() {
	for ABI in $(get_install_abis); do
		cd "${WORKDIR}/${ABI}"

		./configure --prefix="/usr" --libdir="$(get_abi_LIBDIR ${ABI})" || die "./configure failed"
		make CC="$(tc-getCC) $(get_abi_CFLAGS ${ABI})" || die "make failed"
	done
}

src_install() {
	mkdir -p "${D}/etc/yukon/system"

	for ABI in $(get_install_abis); do
		cd "${WORKDIR}/${ABI}"
		make DESTDIR="${D}" install
		cp sysconf "${D}/etc/yukon/system/${ABI}"
	done
}

