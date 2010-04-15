# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils

DESCRIPTION="A Qt4 client for the popular Polish Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
LICENSE="GPL-2"

IUSE="alsa dbus emoticons +gadu +jabber kde phonon sounds spell"

SLOT="0"

DEPEND=">=net-im/kadu-core-${PV}
	>=net-im/kadu-autoaway-${PV}
	>=net-im/kadu-auto_hide-${PV}
	>=net-im/kadu-config_wizard-${PV}
	>=net-im/kadu-sms-${PV}
	>=net-im/kadu-hints-${PV}
	>=net-im/kadu-history-${PV}
	>=net-im/kadu-history_migration-${PV}
	>=net-im/kadu-sql_history-${PV}
	>=net-im/kadu-qt4_docking-${PV}
	alsa? ( >=net-im/kadu-alsa_sound-${PV} )
	phonon? ( >=net-im/kadu-phonon_sound-${PV} )
	emoticons? ( >=net-im/kadu-emoticons-0.6.5 )
	sounds? ( >=net-im/kadu-sounds-0.6.5 )
	dbus? ( >=net-im/kadu-dbus-${PV} )
	gadu? ( >=net-im/kadu-gadu_protocol-${PV} )
	jabber? ( >=net-im/kadu-jabber_protocol-${PV} )
	kde? ( >=net-im/kadu-kde_notify-${PV} )
	spell? ( >=net-im/kadu-spellchecker-${PV} )
"
RDEPEND="${DEPEND}"
