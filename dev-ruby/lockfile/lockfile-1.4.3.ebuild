# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
USE_RUBY="ruby18 ruby19 ree18 jruby"

#RUBY_FAKEGEM_TASK_TEST=""
#RUBY_FAKEGEM_EXTRADOC="CONTRIBUTORS Histroy.txt README.txt ReleaseNotes"

inherit ruby-fakegem

DESCRIPTION="nfs safe lockfile creation"
HOMEPAGE="http://www.codeforpeople.com/lib/ruby/lockfile/"
SRC_URI="http://www.codeforpeople.com/lib/ruby/lockfile/${P}/${P}.gem"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
