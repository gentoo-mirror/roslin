# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit kadu-base

DESCRIPTION="Extra sound themes for Kadu"
HOMEPAGE="http://kadu.net/"
KEYWORDS="amd64 x86"

IUSE=""

SRC_URI="http://www.kadu.net/download/additions/kadu-sound-bns.tar.bz2
	http://www.kadu.net/download/additions/kadu-sound-drums.tar.bz2
	http://www.kadu.net/download/additions/kadu-sound-florkus.tar.bz2
	http://www.kadu.net/download/additions/kadu-sound-michalsrodek.tar.bz2
	http://www.kadu.net/download/additions/kadu-sound-percussion.tar.bz2
	http://www.kadu.net/download/additions/kadu-sound-ultr.tar.bz2"

S="${WORKDIR}"

src_compile()
{
	einfo "Nothing to compile."
}

src_install()
{
	local DIR="/usr/share/kadu/themes/sounds/"

	dodir ${DIR}
	for i in *;
	do
	    mv -f $i "${D}"${DIR};
	done
}
