# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"
inherit flag-o-matic eutils

DESCRIPTION="Use this to make tarballs :)"
HOMEPAGE="http://www.gnu.org/software/tar/"
SRC_URI="http://ftp.gnu.org/gnu/tar/${PN}-${PV}.tar.bz2
		 ftp://alpha.gnu.org/gnu/tar/${PN}-${PV}.tar.bz2
		 mirror://gnu/tar/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86 ~x86-fbsd"
IUSE="7zip +lzma nls static userland_GNU"

RDEPEND="7zip? ( app-arch/p7zip )
		 lzma? ( app-arch/lzma-utils )
		 nls? ( >=sys-devel/gettext-0.10.35 )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gnu-inline.patch #198817
	epatch "${FILESDIR}"/${P}-update-flag.patch #200315

	if use 7zip || use lzma; then
		cp "${FILESDIR}"/tar.1 "${S}"
	fi

	if use 7zip ; then
		epatch "${FILESDIR}"/${PN}-1.19-7zsupport.patch
		epatch "${FILESDIR}"/${PN}-1.19-7zip-man.patch
	fi
	if use lzma ; then
		epatch "${FILESDIR}"/${PN}-1.18-lzma.patch
		epatch "${FILESDIR}"/${PN}-1.19-lzma-man.patch
	fi

	if ! use userland_GNU ; then
		sed -i \
			-e 's:/backup\.sh:/gbackup.sh:' \
			scripts/{backup,dump-remind,restore}.in \
			|| die "sed non-GNU"
	fi
}

src_compile() {
	local myconf
	use static && append-ldflags -static
	use userland_GNU || myconf="--program-prefix=g"
	# Work around bug in sandbox #67051
	gl_cv_func_chown_follows_symlink=yes \
	econf \
		--enable-backup-scripts \
		--bindir=/bin \
		--libexecdir=/usr/sbin \
		$(use_enable nls) \
		$(use_enable 7zip) \
		${myconf} || die
	emake || die "emake failed"
}

src_install() {
	local p=""
	use userland_GNU || p=g

	emake DESTDIR="${D}" install || die "make install failed"

	if [[ -z ${p} ]] ; then
		# a nasty yet required piece of baggage
		exeinto /etc
		doexe "${FILESDIR}"/rmt || die
	fi

	dodoc AUTHORS ChangeLog* NEWS README* PORTS THANKS

	if use 7zip || use lzma; then
		newman "${S}"/tar.1 ${p}tar.1
	else
		newman "${FILESDIR}"/tar.1 ${p}tar.1
	fi

	mv "${D}"/usr/sbin/${p}backup{,-tar}
	mv "${D}"/usr/sbin/${p}restore{,-tar}

	rm -f "${D}"/usr/$(get_libdir)/charset.alias
}
