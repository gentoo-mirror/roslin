# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MY_PN="RT71W_Firmware"
MY_P="${MY_PN}_V${PV}"

DESCRIPTION="Firmware for Ralink rt73-based WiFi USB adapters"
HOMEPAGE="http://web.ralinktech.com/ralink/Home/Support/Linux.html"
SRC_URI="http://www.ralinktech.com.tw/data/${MY_P}.zip"

LICENSE="ralink-firmware"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )"

S="${WORKDIR}/${MY_P}"

src_install() {
	dodir /lib/firmware
	insinto /lib/firmware
	doins rt73.bin
}
