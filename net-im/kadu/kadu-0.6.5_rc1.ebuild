#
# PACKAGE INFORMATION
#
inherit eutils

DESCRIPTION="QT client for popular in Poland Gadu-Gadu IM Network"
HOMEPAGE="http://kadu.net"
KEYWORDS=""
LICENSE="GPL-2"

IUSE="powerkadu alsa esd oss ssl voice"

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
        powerkadu? ( net-im/kadu-powerkadu )
        alsa? ( >=net-im/kadu-alsa_sound-${PV} )
	oss? ( >=net-im/kadu-dsp_sound-${PV} )
        ssl? ( >=net-im/kadu-encryption-${PV} )
	voice? ( >=net-im/kadu-voice-${PV} )
"
