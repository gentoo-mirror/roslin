# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit cmake-utils

MY_PN="${PN/lib/}2"
DESCRIPTION="Simple and fast multimedia library"
HOMEPAGE="http://sfml.sourceforge.net/"
SRC_URI="sfml-2_pre20101226.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="media-libs/freetype:2
	media-libs/libsndfile
	media-libs/openal
	virtual/jpeg
	media-libs/libpng
	media-libs/glew
	sys-libs/zlib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_PN}
