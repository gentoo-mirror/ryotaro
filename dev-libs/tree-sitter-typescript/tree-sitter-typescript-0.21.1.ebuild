# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit tree-sitter-grammar

DESCRIPTION="TypeScript grammar for Tree-sitter"
HOMEPAGE="https://github.com/tree-sitter/tree-sitter-typescript"
S="${WORKDIR}"/${P}/typescript

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
DEPEND="dev-util/tree-sitter-cli"

src_prepare() {
	# fix test corpus path
	ln -s ../common test || die

	tree-sitter-grammar_src_prepare
}
