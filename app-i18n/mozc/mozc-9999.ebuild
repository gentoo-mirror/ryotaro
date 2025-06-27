# https://wiki.gentoo.org/wiki/Basic_guide_to_write_Gentoo_Ebuilds/ja
# https://devmanual.gentoo.org/ebuild-writing/variables/index.html#ebuild-defined-variables
EAPI=8
inherit git-r3
DESCRIPTION="Mozc - Japanese input method editor. Provide the latest version of Mozc hosted on fcitx/mozc for workaround of build failure at 2.28.5029.102-r5."
HOMEPAGE="https://github.com/fcitx/mozc"
SLOT="0"
LICENCE="Google Inc."
# DEPEND="dev-build/bazelisk"
EGIT_REPO_URI="https://github.com/fcitx/mozc"

BazelDistDir="/tmp/mozc/bazel-distdir"

# git fetch is executed in src_unpack.
# https://gitweb.gentoo.org/repo/gentoo.git/tree/app-i18n/mozc/mozc-2.28.5029.102-r5.ebuild#n136
src_unpack() {
    git-r3_fetch $HOMEPAGE
    git-r3_checkout $HOMEPAGE
    curl -o bazel https://releases.bazel.build/8.2.1/release/bazel-8.2.1-linux-x86_64
    chmod +x bazel
    cd mozc-9999/src
    ../../bazel build -c opt --copt=-fPIC --config oss_linux --define server=1 unix/fcitx5:fcitx5-mozc.so server:mozc_server gui/tool:mozc_tool
    cp bazel-bin/unix/fcitx5/fcitx5-mozc.so ../
    cp bazel-bin/server/mozc_server ../
    cp bazel-bin/gui/tool/mozc_tool ../
    mkdir ../fcitx5_data
    PREFIX="../fcitx5_data" ../scripts/install_fcitx5_data
    mkdir ../fcitx5_icons
    PREFIX="../fcitx5_icons" ../scripts/install_fcitx5_icons

}

src_compile() {
    :
}

src_install() {
	exeinto /usr/lib/mozc
	doexe mozc_server
	exeinto /usr/lib/mozc
	doexe mozc_tool

	exeinto /usr/$(get_libdir)/fcitx5
    doexe fcitx5-mozc.so

    insinto /usr/
    doins -r fcitx5_data/share
    doins -r fcitx5_icons/share
}