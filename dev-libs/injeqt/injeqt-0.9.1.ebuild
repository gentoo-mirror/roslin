# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="Dependency injection framework for Qt"
HOMEPAGE="https://github.com/vogel/injeqt"
SRC_URI="https://github.com/vogel/injeqt/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE="test"

DEPEND="dev-qt/qtcore:5
	test? ( dev-qt/qttest:5 )"
RDEPEND="${DEPEND}"

src_configure() {
	# Disable plugins
	use test || local mycmakeargs="-DDISABLE_TESTS:BOOL=ON"

	cmake-utils_src_configure
}
