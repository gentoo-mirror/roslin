# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/color/color-1.4.1.ebuild,v 1.3 2010/05/22 15:07:16 flameeyes Exp $

EAPI="2"
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_DOCDIR=""
RUBY_FAKEGEM_EXTRADOC="History.txt README.txt"

inherit ruby-fakegem

DESCRIPTION="A console-based email client for people with a lot of email"
HOMEPAGE="http://sup.rubyforge.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-ruby/ferret-0.11.6
	dev-ruby/highline
	dev-ruby/lockfile
	>=dev-ruby/mime-types-1
	>=dev-ruby/ncurses-ruby-0.9.1
	dev-ruby/net-ssh
	dev-ruby/ruby-gettext
	>=dev-ruby/ruby-rmail-0.17
	>=dev-ruby/trollop-1.12
	dev-ruby/fastthread"
RDEPEND="${DEPEND}
	dev-libs/xapian-bindings[ruby]"
