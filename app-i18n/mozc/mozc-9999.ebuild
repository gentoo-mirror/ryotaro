# https://wiki.gentoo.org/wiki/Basic_guide_to_write_Gentoo_Ebuilds/ja
# https://devmanual.gentoo.org/ebuild-writing/variables/index.html#ebuild-defined-variables
EAPI=8
inherit git-r3
DESCRIPTION="Mozc - Japanese input method editor. Provide the latest version of Mozc hosted on fcitx/mozc for workaround of build failure at 2.28.5029.102-r5."
HOMEPAGE="https://github.com/fcitx/mozc"
SLOT="0"
LISENCE="Google Inc."
DEPEND="dev-build/bazelisk"
EGIT_REPO_URI="https://github.com/fcitx/mozc"

# git fetch is executed in src_unpack.
# https://gitweb.gentoo.org/repo/gentoo.git/tree/app-i18n/mozc/mozc-2.28.5029.102-r5.ebuild#n136
# src_unpack() {
#     git-r3_fetch $HOMEPAGE
#     git-r3_checkout $HOMEPAGE "${WORKDIR}/fcitx-mozc"
# }
# src_prepare() {
#     echo "prepare"
#     :
# }

src_compile() {
    echo "${WORKDIR}"
    cd "src" || die "Failed to change directory to ${WORKDIR}/src"
    # The source of the command: https://github.com/fcitx/mozc/blob/fcitx/scripts/build_fcitx5_bazel
    bazelisk build -c opt --copt=-fPIC --config oss_linux --define server=1 unix/fcitx5:fcitx5-mozc.so server:mozc_server gui/tool:mozc_tool
}

# bazelisk build -c opt --copt=-fPIC --config oss_linux --define server=1 $_BUILD_TARGETS