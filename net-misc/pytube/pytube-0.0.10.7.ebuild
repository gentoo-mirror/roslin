# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: overlay lapis ebuild deposu Exp $


DESCRIPTION="PyTube is a GUI for youtube-dl and others. It allows you to do multiple tasks like downloading and converting videos from YouTube.com"
HOMEPAGE="http://bashterritory.com/pytube"
SRC_URI="http://www.bashterritory.com/${PN}/releases/${P}.tar.bz2"    

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=">=x11-libs/gtk+-2.0
			>=dev-python/pygtk-2.6.0
			media-video/mplayer
			media-video/ffmpeg2theora
			media-video/ffmpeg
			media-sound/sox"

RDEPEND="${DEPEND}"

src_unpack() {
     unpack ${A}
     cd ${S}
     sed -i -e "s/\.\/pytube/python pytube/" pytube     
}

src_compile() {
	:;
}


src_install() {
       dobin pytube
       
       insinto /usr/share/applications/
       doins pytube.desktop
       
       insinto /usr/share/pytube
       doins *	         
       	
}
