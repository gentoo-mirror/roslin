#
# PACKAGE INFORMATION
#
inherit eutils

DESCRIPTION="A QT client for the popular Polish Gadu-Gadu IM network"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"

IUSE="emoticons icons sounds powerkadu alsa oss ssl voice"

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
	emoticons? ( >=net-im/kadu-emoticons-${PV} )
	icons? ( >=net-im/kadu-icons-${PV} )
	sounds? ( >=net-im/kadu-sounds-${PV} )
"
