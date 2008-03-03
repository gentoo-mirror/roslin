# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit eutils java-pkg-2

IUSE="gtk"
DESCRIPTION="P2P Gnutella/Bittorrent client"
HOMEPAGE="http://www.frostwire.com/"

# If you find a better way of doing this, feel free to change it
SV=${PV::$(expr "${PV}" : "^[0-9]*\.[0-9]*\.[0.9]*" + 1)}

SRC_URI="http://light.frostwire.com/4.13.4/${P}.noarch.tar.gz"
LICENSE="GPL-2 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=virtual/jre-1.4.1
	<dev-java/commons-httpclient-3
	dev-java/commons-logging
	dev-java/commons-net
	dev-java/icu4j
	dev-java/jmdns
	dev-java/log4j
	dev-java/xml-commons-external"

RDEPEND=">=virtual/jre-1.4.1
	gtk? ( >=x11-libs/gtk+-2.4 )"

S="${WORKDIR}/${PN}-${SV}.noarch"
PREFIX="/opt/${PN}"

src_install() {
	java-pkg_jarinto "${PREFIX}"
	java-pkg_dojar $(java-pkg_find-normal-jars "${S}")

	cd "${D}${PREFIX}"
	java-pkg_jar-from commons-httpclient commons-httpclient.jar
	java-pkg_jar-from commons-logging commons-logging.jar
	java-pkg_jar-from commons-net commons-net.jar
#	java-pkg_jar-from commons-pool commons-pool.jar
	java-pkg_jar-from icu4j icu4j.jar
	java-pkg_jar-from jmdns jmdns.jar
	java-pkg_jar-from log4j log4j.jar
	java-pkg_jar-from xml-commons-external-1.3 xml-apis.jar

	insinto	${PREFIX}
	doins "${S}"/*.properties "${S}"/*.war "${S}"/*.ver "${S}"/*.gif
	touch "${D}${PREFIX}"/hashes
	dodoc "${S}"/changelog

	java-pkg_dolauncher \
		frostwire --jar "${PREFIX}"/FrostWire.jar \
		--pwd "${PREFIX}"
	exeinto /usr/bin
	doexe frostwire

	newicon "${FILESDIR}"/main-icon.png frostwire.png

	make_desktop_entry frostwire FrostWire
}
