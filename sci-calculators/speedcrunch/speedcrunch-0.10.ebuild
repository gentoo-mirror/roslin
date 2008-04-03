# Copyright 2006-2008 Marco Wegner <devel@marcowegner.de>

inherit eutils qt4

DESCRIPTION="A fast and usable calculator for power users."
HOMEPAGE="http://speedcrunch.org/"
SRC_URI="http://speedcrunch.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="nomirror"

DEPEND="$(qt4_min_version 4.2)
        >=dev-util/cmake-2.4.6"
	
src_compile()
{
	cmake -DCMAKE_INSTALL_PREFIX=/usr src || die "cmake failed"
	emake || die "emake failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "emake install failed"

	# install the docs
	dodoc ChangeLog Changelog.floatnum HACKING.txt LISEZMOI PACKAGERS README TRANSLATORS
}

