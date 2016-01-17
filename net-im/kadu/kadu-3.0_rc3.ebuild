# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="A multi-protocol IM client written in Qt4"
HOMEPAGE="http://kadu.im"
KEYWORDS=""
LICENSE="GPL-2"

IUSE="debug +emoticons +gadu +jabber +phonon spell ssl"

SLOT="0"

RDEPEND=">=net-im/kadu-core-${PV}[debug?]
	>=net-im/kadu-autoaway-${PV}[debug?]
	>=net-im/kadu-auto_hide-${PV}[debug?]
	>=net-im/kadu-config_wizard-${PV}[debug?]
	>=net-im/kadu-sms-${PV}[debug?]
	>=net-im/kadu-hints-${PV}[debug?]
	>=net-im/kadu-history-${PV}[debug?]
	>=net-im/kadu-history_migration-${PV}[debug?]
	>=net-im/kadu-profiles_import-${PV}[debug?]
	>=net-im/kadu-sql_history-${PV}[debug?]
	>=net-im/kadu-docking-${PV}[debug?]
	>=net-im/kadu-freedesktop_notify-${PV}[debug?]
	emoticons? ( >=net-im/kadu-emoticons-${PV}[debug?] )
	phonon? ( >=net-im/kadu-phonon_sound-${PV}[debug?] )
	gadu? ( >=net-im/kadu-gadu_protocol-${PV}[debug?] )
	jabber? ( >=net-im/kadu-jabber_protocol-${PV}[debug?] )
	spell? ( >=net-im/kadu-spellchecker-${PV}[debug?] )
	ssl? ( >=net-im/kadu-encryption_ng_simlite-${PV}[debug?] )
	!net-im/kadu-desktop_docking
	!net-im/kadu-qt4_docking
	!net-im/kadu-qt4_docking_notify
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"
