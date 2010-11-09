# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils subversion games

DESCRIPTION="FTE QuakeWorld (Quake 1) client & server"
HOMEPAGE="http://www.fteqw.com/"
# mirror://sourceforge/${PN}/ftesrc${PV}-all.zip
SRC_URI=""

ESVN_REPO_URI="https://${PN}.svn.sourceforge.net/svnroot/${PN}/trunk"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug dedicated opengl X"

S=${WORKDIR}/engine
dir=${GAMES_DATADIR}/quake1

RDEPEND="media-libs/alsa-lib
	media-libs/libogg
	media-libs/libpng
	media-libs/libvorbis
	net-libs/gnutls
	virtual/jpeg
	virtual/opengl
	media-libs/libsdl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86vm"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"

src_unpack() {
	#unpack ${A}
	subversion_src_unpack
	cd "${S}/engine"

	# Use shared directory
	sed -i \
		-e "s:\".\":\"${dir}\":" \
		client/sys_linux.c || die "sed sys_linux.c failed"

	# Use home directory:  ~/.fte/fte/fte.cfg
	sed -i \
		-e "s:\*com_homedir = '\\\0';:printf;:" \
		-e "s:Con_Printf(\"Using home directory:Sys_mkdir (com_homedir);\n\t\tSys_mkdir (va(\"%sfte\", com_homedir));\n\t\tCon_Printf(\"Using home directory:" \
		common/fs.c || die "sed fs.c failed"
}

src_compile() {
	cd engine

	local target="gl"
	use X && ! use opengl && target="sw"
	use dedicated && ! use X && ! use opengl && target="sv"

	local asm="NO"
	use x86 && asm="YES"

	if use debug ; then
		target="${target}-dbg"
	else
		target="${target}-rel"
	fi

	# Sets up config.h with everything enabled
	emake autoconfig || die "emake autoconfig failed"

	emake \
		USEASM=${asm} \
		RELEASE_DIR="release" \
		DEBUG_DIR="release" \
		STRIP="echo" \
		STRIPFLAGS="" \
		"${target}" \
		|| die "emake ${target} failed"
}

src_install() {
	# A single executable is created
	newgamesbin engine/release/${PN}* ${PN} || die "newgamesbin failed"

	# No icon
	make_desktop_entry ${PN} "FTE QuakeWorld"

	prepgamesdirs
}
