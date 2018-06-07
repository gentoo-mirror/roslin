# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="A multi-protocol IM client written in Qt4"
HOMEPAGE="http://kadu.im"
KEYWORDS="~amd64 ~x86"
LICENSE="GPL-2"

IUSE="debug +emoticons +gadu +jabber spell"

SLOT="0"

RDEPEND=">=net-im/kadu-core-${PV}[debug?]
	>=net-im/kadu-autoaway-${PV}[debug?]
	>=net-im/kadu-auto_hide-${PV}[debug?]
	>=net-im/kadu-config_wizard-${PV}[debug?]
	>=net-im/kadu-sms-${PV}[debug?]
	>=net-im/kadu-hints-${PV}[debug?]
	>=net-im/kadu-history-${PV}[debug?]
	>=net-im/kadu-sql_history-${PV}[debug?]
	>=net-im/kadu-docking-${PV}[debug?]
	>=net-im/kadu-freedesktop_notify-${PV}[debug?]
	emoticons? ( >=net-im/kadu-emoticons-${PV}[debug?] )
	gadu? ( >=net-im/kadu-gadu_protocol-${PV}[debug?] )
	jabber? ( >=net-im/kadu-jabber_protocol-${PV}[debug?] )
	spell? ( >=net-im/kadu-spellchecker-${PV}[debug?] )
	!net-im/kadu-desktop_docking
	!net-im/kadu-qt4_docking
	!net-im/kadu-qt4_docking_notify
	!net-im/kadu-encryption_ng
	!net-im/kadu-encryption_ng_simlite
	!net-im/kadu-history_migration
	!net-im/kadu-profiles_import
	!net-im/kadu-phonon_sound
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
