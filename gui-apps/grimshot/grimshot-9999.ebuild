EAPI=8
inherit bash-completion-r1

DESCRIPTION="Grimshot is a helper for screenshots within sway"
HOMEPAGE="https://github.com/OctopusET/sway-contrib"
SRC_URI="https://github.com/OctopusET/sway-contrib/archive/refs/heads/master.zip"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="+bash-completion"

DEPEND="(
  gui-apps/grim
  gui-apps/slurp
  bash-completion? ( app-shells/bash-completion )
)"
RDEPEND="${DEPEND}"
BDEPEND=""

src_unpack() {
	if [[ -n ${A} ]]; then
		unpack ${A}
		mv sway-contrib-master grimshot-${PV}
	fi
}

src_install() {
	dobin grimshot
	doman grimshot.1
	newbashcomp grimshot-completion.bash ${PN}
}
