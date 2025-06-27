# https://wiki.gentoo.org/wiki/Basic_guide_to_write_Gentoo_Ebuilds/ja
# https://devmanual.gentoo.org/ebuild-writing/variables/index.html#ebuild-defined-variables
EAPI=8
inherit git-r3
DESCRIPTION="Mozc - Japanese input method editor. Provide the latest version of Mozc hosted on fcitx/mozc for workaround of build failure at 2.28.5029.102-r5."
HOMEPAGE="https://github.com/fcitx/mozc"
SLOT="0"
LICENCE="Google Inc"
EGIT_REPO_URI="https://github.com/fcitx/mozc"

BCR_URL=https://github.com/bazelbuild/bazel-central-registry
BAZEL_URL=https://releases.bazel.build/8.2.1/release/bazel-8.2.1-linux-x86_64

BUILD_OPTIONS="-c opt --copt=-fPIC --config oss_linux --define server=1 unix/fcitx5:fcitx5-mozc.so server:mozc_server gui/tool:mozc_tool"
# https://zenn.dev/phoepsilonix/articles/mozc-offiline-build
src_unpack() {
    git-r3_fetch $HOMEPAGE
    git-r3_checkout $HOMEPAGE
    git-r3_fetch $BCR_URL 
    git-r3_checkout $BCR_URL bcr 
    curl -o bazel ${BAZEL_URL} || die "Failed to download bazel"
    chmod +x bazel
    cd mozc-${PV}/src || die
    ../../bazel fetch --build_event_json_file=../../bep.json --experimental_repository_resolved_file=../../resolved.bzl --repository_cache="../../bazel-cache" --registry=file://$(pwd)/../../bcr $BUILD_OPTIONS || die
}
# Network access is not avaiable.
src_compile() {
    cd src
    ../../bazel clean --expunge
    ../../bazel build --repository_cache=../../bazel-cache --registry=file://$(pwd)/../../bcr $BUILD_OPTIONS
    cp bazel-bin/unix/fcitx5/fcitx5-mozc.so ../../
    cp bazel-bin/server/mozc_server ../../
    cp bazel-bin/gui/tool/mozc_tool ../../
    mkdir ../../fcitx5_data
    PREFIX="../../fcitx5_data" ../scripts/install_fcitx5_data
    mkdir ../../fcitx5_icons
    PREFIX="../../fcitx5_icons" ../scripts/install_fcitx5_icons
}

src_install() {
    # work
    cd ..
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