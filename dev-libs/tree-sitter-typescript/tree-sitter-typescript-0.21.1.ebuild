# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="tree-sitter-typescript"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-typescript"
#SRC_URI="git@github.com:tree-sitter/tree-sitter-typescript.git"
EGIT_REPO_URI=https://github.com/tree-sitter/tree-sitter-typescript.git
GIT_BRANCH="v0.21.1"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_test() {
	:
}
