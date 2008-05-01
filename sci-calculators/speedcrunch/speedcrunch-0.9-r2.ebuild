# Copyright 2006-2008 Marco Wegner <devel@marcowegner.de>

inherit eutils qt4 cmake-utils

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


src_unpack( )
{
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-adjust-paths.patch"
}

src_compile()
{
	cmake -DCMAKE_INSTALL_PREFIX=/usr src || die "cmake failed"
	emake || die "emake failed"
}

src_install()
{
	# ATTN: using einstall doesn't seem to work here!

	# variables for binary and icon
	local MY_BIN="speedcrunch"
	local MY_ICON="src/resources/crunch.png"

	# install the binary
	dobin ${MY_BIN}

	# install the docs
	dodoc {COPYING,ChangeLog,HACKING.txt,LISEZMOI,PACKAGERS,README,TRANSLATORS}

	# install the translation files
	insinto /usr/share/${PN}/translations
	doins src/crunch_*.qm

	# and finally, create a desktop entry
	newicon ${MY_ICON} ${PN}.png
	make_desktop_entry ${MY_BIN} "SpeedCrunch" ${PN} "Qt;Calculator;Utility"
}
