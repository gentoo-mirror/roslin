# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="A Qt4 client for the popular Polish Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
LICENSE="GPL-2"

IUSE="alsa debug dbus emoticons +gadu +jabber kde phonon sounds spell"

SLOT="0"

DEPEND=">=net-im/kadu-core-${PV}[debug?]
	>=net-im/kadu-autoaway-${PV}[debug?]
	>=net-im/kadu-auto_hide-${PV}[debug?]
	>=net-im/kadu-config_wizard-${PV}[debug?]
	>=net-im/kadu-sms-${PV}[debug?]
	>=net-im/kadu-hints-${PV}[debug?]
	>=net-im/kadu-history-${PV}[debug?]
	>=net-im/kadu-history_migration-${PV}[debug?]
	>=net-im/kadu-sql_history-${PV}[debug?]
	>=net-im/kadu-qt4_docking-${PV}[debug?]
	alsa? ( >=net-im/kadu-alsa_sound-${PV}[debug?] )
	phonon? ( >=net-im/kadu-phonon_sound-${PV}[debug?] )
	emoticons? ( >=net-im/kadu-emoticons-0.6.5 )
	sounds? ( >=net-im/kadu-sounds-0.6.5 )
	dbus? ( >=net-im/kadu-dbus-${PV}[debug?] )
	gadu? ( >=net-im/kadu-gadu_protocol-${PV}[debug?] )
	jabber? ( >=net-im/kadu-jabber_protocol-${PV}[debug?] )
	kde? ( >=net-im/kadu-kde_notify-${PV}[debug?] )
	spell? ( >=net-im/kadu-spellchecker-${PV}[debug?] )
"
RDEPEND="${DEPEND}"
