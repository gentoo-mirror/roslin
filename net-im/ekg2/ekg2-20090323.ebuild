# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

WANT_AUTOCONF=latest
#WANT_AUTOMAKE=1.7

inherit eutils flag-o-matic perl-module autotools

DESCRIPTION="Text based Instant Messenger and IRC client that supports protocols like Jabber and Gadu-Gadu"
HOMEPAGE="http://pl.ekg2.org/"
SRC_URI="http://pl.ekg2.org/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="crypt gif gpm gsm gtk inotify jabber jpeg nls nogg perl python remote spell sqlite sqlite3 ssl unicode xosd"

DEPEND="crypt? ( app-crypt/gpgme )
	gif? ( media-libs/giflib )
	gpm? ( >=sys-libs/gpm-1.20.1 )
	gsm? ( >=media-sound/gsm-1.0.10 )
	gtk? ( >=x11-libs/gtk+-2.4 )
	inotify? ( sys-fs/inotify-tools )
	jabber? ( >=dev-libs/expat-1.95.6 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	!nogg? ( >=net-libs/libgadu-1.7.0 )
	perl? ( >=dev-lang/perl-5.2 )
	python? ( >=dev-lang/python-2.3.3 )
	spell? ( >=app-text/aspell-0.50.5 )
	sqlite? ( !sqlite3? ( =dev-db/sqlite-2* ) )
	sqlite3? ( >=dev-db/sqlite-3 )
	ssl? ( >=dev-libs/openssl-0.9.6
		jabber? ( >=net-libs/gnutls-1.0.17 ) )
	xosd? ( x11-libs/xosd )
	virtual/libintl
	sys-libs/ncurses[unicode?]"

RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
}

src_configure() {
#	export WANT_AUTOMAKE="1.7"
	export WANT_AUTOMAKE="latest"

	econf \
		"--with-pthread" \
		"--without-readline" \
		$(use_with crypt gpg) \
		$(use_with gif libgif) \
		$(use_with gif gif) \
		$(use_with gif libungif) \
		$(use_with gpm gpm-mouse) \
		$(use_with gsm libgsm) \
		$(use_with gtk) \
		$(use_with inotify) \
		$(use_with jabber expat) \
		$(use_with jpeg libjpeg) \
		$(use_enable nls) \
		$(use_with !nogg libgadu) \
		$(use_with perl) \
		$(use_with python) \
		$(use_enable remote) \
		$(use_with spell aspell) \
		$(use_with sqlite) \
		$(use_with sqlite3) \
		$(use_with ssl openssl) \
		$(use_enable unicode) \
		$(use_with xosd libxosd) \
		`use jabber && use ssl && echo --with-libgnutls` \
		|| die "econf failed"
}

src_install() {
	# Install plugins into proper directory
	if use amd64; then
		CONF_LIBDIR=$(getlib)/lib/ekg2/plugins
	fi

	# einstall messes up perl
	emake DESTDIR="${D}" install || die "einstall failed"
	dodoc docs/* || die "dodoc failed"

	use perl && fixlocalpod
}

pkg_postinst() {
	if use gtk; then
		ewarn "Ekg2 GTK2 frontend is highly experimental."
		ewarn "Please do not file bugs about it."
	fi

#	use perl && updatepod
}
