# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils multilib git-r3

DESCRIPTION="LuaZip is a lightweight lua library to read files from zip archives."
HOMEPAGE="https://github.com/msva/luazip"
EGIT_REPO_URI="https://github.com/msva/luazip.git"

if [[ ${PV} == 9999* ]]; then
	KEYWORDS=""
else
	KEYWORDS="amd64 x86"
	EGIT_COMMIT="v${PV}"
fi

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	>=dev-lang/lua-5.1:*
	dev-libs/zziplib
"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i \
		-e "s|gcc|$(tc-getCC)|" \
		-e "s|-O2|${CFLAGS}|" \
		-e "s|/usr/local|/usr|" \
		-e "s|/lib|/$(get_libdir)|" \
		-e "/^LIB_OPTION/s|= |= ${LDFLAGS} |" \
		config
}

src_install() {
	emake PREFIX="${ED}/usr" install
}
