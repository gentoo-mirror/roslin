# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit games

DESCRIPTION="An open source implementation of the RealLive virtual machine for Linux and OSX"
HOMEPAGE="http://www.elliotglaysher.org/rlvm/"
SRC_URI="http://github.com/eglaysher/${PN}/tarball/release-${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl[opengl]
	>=dev-libs/boost-1.42
	media-libs/glew
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	media-libs/libmad
	>=dev-games/guichan-0.8[opengl,sdl]"

DEPEND="${RDEPEND}
	dev-util/scons
	>=net-misc/wget-1.12-r3"

S="${WORKDIR}/eglaysher-rlvm-2af821f"

src_prepare() {
	# custom flag goodness
	epatch "${FILESDIR}/${PN}-custom-flags.patch"
}

src_compile() {
	scons --release \
	CFLAGS="${CFLAGS}" \
	LDFLAGS="${LDFLAGS}" \
	|| die "build failed"
}

src_install() {
	dogamesbin "build/${PN}" || die "dobin failed"
	dodoc {AUTHORS,NEWS,README,STATUS}.TXT
	doman debian/${PN}.6

	prepgamesdirs
}
