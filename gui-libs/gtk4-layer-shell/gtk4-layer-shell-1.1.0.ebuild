EAPI=8
DESCRIPTION="A library for using the Layer Shell Wayland protocol with GTK4."
HOMEPAGE="https://github.com/wmww/gtk4-layer-shell"
SRC_URI="https://github.com/wmww/${PN}/archive/refs/tags/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
# https://devmanual.gentoo.org/ebuild-writing/variables/#ebuild-defined-variables
IUSE="vala docs introspection test smoke-tests examples"
KEYWORDS="~amd64"
inherit meson

RDEPEND="
	>=gui-libs/gtk-4.10.5[wayland]
"

DEPEND="${RDEPEND}"

src_configure() {
	local emesonargs=(
		# meson_use <USE flag> [option name]
		# https://devmanual.gentoo.org/eclass-reference/meson.eclass/index.html
		$(meson_use vala vapi)
		$(meson_use examples)
		# "-Dexamples=false"
		$(meson_use test tests)
		$(meson_use smoke-tests)
		$(meson_use docs)
		$(meson_use introspection)
	)
	meson_src_configure

}
