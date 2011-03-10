# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils

DESCRIPTION="A Qt4 client for the popular Polish Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"

IUSE="emoticons icons sound powerkadu alsa oss ssl voice phonon dbus"

SLOT="0"

DEPEND=">=net-im/kadu-core-${PV}
	>=net-im/kadu-account_management-${PV}
	>=net-im/kadu-advanced_userlist-${PV}
	>=net-im/kadu-autoaway-${PV}
	>=net-im/kadu-autoresponder-${PV}
	>=net-im/kadu-config_wizard-${PV}
	>=net-im/kadu-default_sms-${PV}
	>=net-im/kadu-dcc-${PV}
	>=net-im/kadu-hints-${PV}
	>=net-im/kadu-history-${PV}
	>=net-im/kadu-window_notify-${PV}
	>=net-im/kadu-qt4_docking-${PV}
	powerkadu? ( ~net-im/kadu-powerkadu-${PV} )
	alsa? ( >=net-im/kadu-alsa_sound-${PV} )
	oss? ( >=net-im/kadu-dsp_sound-${PV} )
	phonon? ( >=net-im/kadu-phonon_sound-${PV} )
	ssl? ( >=net-im/kadu-encryption-${PV} )
	voice? ( >=net-im/kadu-voice-${PV} )
	emoticons? ( >=net-im/kadu-emoticons-0.6.5 )
	icons? ( >=net-im/kadu-icons-0.6.5 )
	sound? ( >=net-im/kadu-sounds-0.6.5 )
	dbus? ( >=net-im/kadu-dbus-${PV} )
"
RDEPEND="${DEPEND}"
