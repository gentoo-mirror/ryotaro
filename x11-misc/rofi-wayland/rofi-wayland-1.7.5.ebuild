# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A Fork of Rofi with wayland support"
HOMEPAGE="https://github.com/lbonn/rofi/tree/wayland"
SRC_URI="https://github.com/lbonn/rofi/releases/download/1.7.5%2Bwayland3/rofi-1.7.5+wayland3.tar.gz"
LICENSE="MIT"
# https://devmanual.gentoo.org/general-concepts/slotting/index.html
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
    x11-libs/xcb-util-cursor
    x11-libs/startup-notification"

RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	if [[ -n ${A} ]]; then
        unpack ${A}
		# Rename the created directory to the name that the following steps expect.
		mv rofi-${PV}+wayland3 ${P}
	fi
}
