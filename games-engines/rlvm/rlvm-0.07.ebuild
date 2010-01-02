# Copyright 1999-2010 Gentoo Foundation
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
	>=dev-libs/boost-1.35
	media-libs/glew
	media-libs/sdl-image[jpeg,png]
	media-libs/sdl-ttf
	media-libs/sdl-mixer[vorbis]
	media-libs/libmad"

DEPEND="${RDEPEND}
	dev-util/scons"

S="${WORKDIR}/eglaysher-rlvm-55b0a78"

src_prepare() {
	# custom flag goodness
	epatch "${FILESDIR}/${PN}-custom-flags.patch"

	# make it build with 1.35 at our own discretion
	sed -e "s:'1.40':'1.35':" \
	-i SConstruct \
	|| die "sed failed"
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
