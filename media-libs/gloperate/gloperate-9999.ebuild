# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 cmake-utils

DESCRIPTION="C++ library for defining and controlling GPU rendering/processing operations"
HOMEPAGE="https://github.com/cginternals/gloperate"
#SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples ffmpeg glfw hidapi qt5 static-libs tests tools"

RDEPEND="
	dev-cpp/cppexpose:*
	dev-cpp/cppassist:*
	dev-cpp/cpplocate:*
	media-libs/glkernel:*
	>=media-libs/glbinding-3.0.0:*
	>=media-libs/glm-0.9.9:*
	>media-libs/globjects-1.1.0:*
	media-libs/openll:*
	>media-libs/qmltoolbox-1.1.0:*
	glfw? ( >=media-libs/glfw-3.1:* )
	qt5? ( >=dev-qt/qtcore-5.1:5 >=dev-qt/qtgui-5.1:5 >=dev-qt/qtwidgets-5.1:5 >=dev-qt/qtopengl-5.1:5 )
	ffmpeg? ( media-video/ffmpeg:* )
	hidapi? ( dev-libs/hidapi:* )
	examples? ( media-libs/assimp:* )"
DEPEND="${RDEPEND}
	>=dev-util/cmake-3.0:*
	doc? ( >=app-doc/doxygen-1.8:* )"

EGIT_REPO_URI="https://github.com/lordgeorg/gloperate.git"
EGIT_BRANCH="master"
# not set so that smart-live-rebuild recognize this package as a live one
#EGIT_COMMIT="HEAD"
EGIT_SUBMODULES=( '*' )

#CONFIG_CHECK=""

CMAKE_MAKEFILE_GENERATOR="emake"

src_prepare() {
	# user patches:
	epatch "${FILESDIR}/version-9999.patch"

	# already includes epatch_user:
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DOPTION_BUILD_TOOLS=$(usex tools)
		-DOPTION_BUILD_EXAMPLES=$(usex examples)
		-DOPTION_BUILD_DOCS=$(usex doc)
		-DOPTION_BUILD_TESTS=$(usex tests)
		-DBUILD_SHARED_LIBS=$(usex static-libs OFF ON)
	)

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
