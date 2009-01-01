#
# PACKAGE INFORMATION
#
inherit eutils kadu

DESCRIPTION="QT client for popular in Poland Gadu-Gadu IM Network"
HOMEPAGE="http://kadu.net"
KEYWORDS="amd64 x86"
LICENSE="GPL-2"

IUSE="
    nodefmodules powerkadu
    emoticons icons sounds
    alsa arts dcop esd oss ssl voice
"

SLOT="0"

DEPEND="
    >=net-im/kadu-core-${MIN_REQ}

    !nodefmodules? (
	>=net-im/kadu-account_management-${MIN_REQ}
	>=net-im/kadu-config_wizard-${MIN_REQ}
	>=net-im/kadu-default_sms-${MIN_REQ}
	>=net-im/kadu-dcc-${MIN_REQ}
	>=net-im/kadu-hints-${MIN_REQ}
	>=net-im/kadu-history-${MIN_REQ}
	>=net-im/kadu-migration-${MIN_REQ}
	>=net-im/kadu-notify-${MIN_REQ}
	>=net-im/kadu-x11_docking-${MIN_REQ}
    )
    
    powerkadu? ( net-im/kadu-powerkadu )

    emoticons? ( net-im/kadu-emoticons )
    icons? ( net-im/kadu-icons )
    sounds? ( net-im/kadu-sounds )
    
    alsa? ( >=net-im/kadu-alsa_sound-${MIN_REQ} )
    arts? ( >=net-im/kadu-arts_sound-${MIN_REQ} )
    dcop? ( net-im/kadu-dcopexport )
    esd? ( >=net-im/kadu-esd_sound-${MIN_REQ} )
    oss? ( >=net-im/kadu-dsp_sound-${MIN_REQ} )
    ssl? ( >=net-im/kadu-encryption-${MIN_REQ} )
    voice? ( >=net-im/kadu-voice-${MIN_REQ} )
"

#
# PACKAGE BUILDING AND INSTALATION
#
src_install()
{
	dosbin ${FILESDIR}/kadu_modrebuild \
	|| die "kadu_modrebuild installation failed!"
}

#
# PRINT INFORMATION
#
pkg_postinst()
{
	ewarn "NOTE: This package provides only basic Kadu modules, if you need more"
	ewarn "you may have to install separate packages."
	einfo "To list available Kadu modules and additions, run:"
	einfo "     emerge --search kadu-\n"
	ewarn "NOTE: After upgrading main Kadu package you may have to rebuild all of"
	ewarn "your modules because they may misbehave. To do so, just run:"
	ewarn "     kadu_modrebuild"
	echo
	ebeep 5
	sleep 5
}

pkg_postrm()
{
	ewarn "Remember to remove/reinstall remaining Kadu modules!"
	echo
	sleep 5
}
