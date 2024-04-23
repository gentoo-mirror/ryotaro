EAPI=8
DESCRIPTION="Hyprshot is an utility to easily take screenshot in Hyprland using your mouse."
HOMEPAGE="https://github.com/Gustash/Hyprshot"
SRC_URI="https://github.com/Gustash/Hyprshot/archive/refs/tags/1.2.3.tar.gz"
LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="amd64"
IUSE=""

DEPEND="(
    gui-apps/slurp
	gui-apps/grim
)"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
    if [[ -n ${A} ]]; then
        unpack ${A}
		mv Hyprshot-${PV} hyprshot-${PV}
    fi
}

src_install() {
	mkdir -p ${D}/usr/bin
	cp hyprshot ${D}/usr/bin
}

