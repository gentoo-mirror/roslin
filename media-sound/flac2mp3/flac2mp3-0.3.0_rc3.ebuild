# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:$

inherit versionator
IUSE=""

DESCRIPTION="A perl script to convert FLAC files to mp3 files."

MY_PV=$(delete_version_separator 3)
MY_PF=${PN}-${MY_PV}

HOMEPAGE="http://robinbowes.com/projects/flac2mp3/"
SRC_URI="http://robinbowes.com/download/flac2mp3/${MY_PF}.tar.gz"

LICENSE="Artistic"

SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=""
RDEPEND="dev-perl/Audio-FLAC-Header
	dev-perl/MP3-Tag
	dev-perl/File-Which
	dev-perl/File-Find-Rule
	dev-perl/Text-Glob
	dev-perl/Number-Compare
	media-libs/flac
	media-sound/lame"

S=${WORKDIR}/${MY_PF}

# src_unpack(){
# 	cp ${DISTDIR}/${A} ${S}
# 	epatch ${FILESDIR}/${PF}-mpg321.patch
# 	epatch ${FILESDIR}/${PF}-quality.patch
# }

src_install() {
	newbin flac2mp3.pl flac2mp3
	dodoc *.txt
}
