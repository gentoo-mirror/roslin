inherit eutils qt3

DESCRIPTION="Jabbin is an Open Source Jabber client program that allows free PC to PC calls using the VoIP system over the Jabber network."
HOMEPAGE="http://www.jabbin.com/"
VER="2.0beta2a"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${VER}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""
RESTRICT="mirror primaryuri"

DEPEND="$(qt_min_version 3.1)
	net-misc/rsync
	>=app-crypt/qca-1.0
	media-libs/speex
	net-libs/libjingle
	>=sys-libs/zlib-1.1.4
	=dev-libs/jrtplib-3.5*
	dev-libs/ilbc-rfc3951"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${VER}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-makefile.patch
	epatch ${FILESDIR}/${PN}-nodebug.patch
	#chmod +x configure
	
	use amd64 && epatch ${PN}-${VER}_amd64.patch
}

src_compile() {
	# configure script is buggy, so we can't use econf
	#./configure || die
	eqmake3 || die
	emake || die
}

src_install() {
	dobin src/jabbin
	dodoc README INSTALL COPYING
	dodir /usr/share/jabbin
	rsync -rlptDv --exclude=.svn --exclude=readme sound iconsets "${D}"/usr/share/jabbin/
}
