# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="QML item library for cross-platform graphics applications"
HOMEPAGE="https://github.com/cginternals/qmltoolbox"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples doc static-libs"

RDEPEND="
	dev-cpp/cpplocate:*
	>media-libs/glm-0.9:*
	>=dev-qt/qtcore-5.4:5
	>=dev-qt/qtdeclarative-5.4:5
	examples? ( >=dev-qt/qtgui-5.4:5 >=dev-qt/qtwidgets-5.4:5 )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0:*
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/cginternals/qmltoolbox.git"
EGIT_BRANCH="master"
EGIT_COMMIT="1d127c4a00e996291f79e8dec192688046f21fc2"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	# user patches:

	# already includes epatch_user:
	cmake-utils_src_prepare
}

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_test() {
	cmake-utils_src_test
}

src_install() {
	cmake-utils_src_install

# fix multilib-strict QA failures
	mv "${ED%/}"/usr/{lib,$(get_libdir)} || die
}

#pkg_postinst() {
#}
