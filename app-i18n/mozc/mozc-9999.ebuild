# https://wiki.gentoo.org/wiki/Basic_guide_to_write_Gentoo_Ebuilds/ja
# https://devmanual.gentoo.org/ebuild-writing/variables/index.html#ebuild-defined-variables
EAPI=8
inherit git-r3
DESCRIPTION="Mozc - Japanese input method editor. Provide the latest version of Mozc hosted on fcitx/mozc for workaround of build failure at 2.28.5029.102-r5."
HOMEPAGE="https://github.com/fcitx/mozc"
SLOT="0"
LISENCE="Google Inc."
DEPEND="dev-build/bazelisk"
EGIT_REPO_URI="git@github.com:fcitx/mozc.git"

src_unpack() {
    git-r3_fetch $HOMEPAGE
    pwd
    ls -la
}