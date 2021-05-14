# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils multilib

DESCRIPTION="NVIDIA container runtime library and nvidia-container-cli tool"
HOMEPAGE="https://github.com/NVIDIA/libnvidia-container"
KEYWORDS="*"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND="net-libs/libtirpc"
RDEPEND="$COMMON_DEPEND "

TARBALL_PV=${PV}
NV_GITHUB_REPO="libnvidia-container"
NV_GITHUB_USER="NVIDIA"
NV_GITHUB_TAG="v${PV}"

ETC_REPO="elftoolchain"
ETC_TAG="0.7.1"
ETC="${ETC_REPO}-${ETC_TAG}"
NV_MOD_REPO="nvidia-modprobe"
NV_MOD_TAG="450.57"
NV_MOD="${NV_MOD_REPO}-${NV_MOD_TAG}"

SRC_URI="
https://www.github.com/${NV_GITHUB_USER}/${NV_GITHUB_REPO}/archive/v${PV}.tar.gz -> ${NV_GITHUB_REPO}-${PV}.tar.gz
https://sourceforge.net/projects/elftoolchain/files/Sources/${ETC}/${ETC}.tar.bz2
https://github.com/NVIDIA/${NV_MOD_REPO}/archive/${NV_MOD_TAG}.tar.gz -> ${NV_MOD_REPO}-${NV_MOD_TAG}.tar.gz
"
S=${WORKDIR}/${NV_GITHUB_REPO}-${PV}

src_unpack() {
    unpack ${A}
    mkdir -p ${S}/deps/src
	mv ${WORKDIR}/${NV_MOD} ${S}/deps/src
	mv ${WORKDIR}/${ETC} ${S}/deps/src
}

src_prepare() {
    default
	patch -d deps/src/${NV_MOD} -p1 < mk/nvidia-modprobe.patch

	# The original makefile assumes a git repository
	# fill in the correct revision (tag v1.4.0) in the makefile
	# NOTE: If this ebuild is updated, this should also be updated to a new revision
	sed -i 's/git rev-parse HEAD/echo 704a698b7a0ceec07a48e56c37365c741718c2df/' mk/common.mk

	# Remove "all" dependency to prevent installation of built-in dependencies
	sed -i 's/^install: all$/install:/' Makefile

	# Fake download stamps since these have been provided by the ebuild
	touch deps/src/${NV_MOD}/.download_stamp
	touch deps/src/${ETC}/.download_stamp
}

src_compile() {
	# Override internal libtirpc with system libtirpc
	# Fix a linker error by also appending -fPIC on non-hardened profiles
    emake CFLAGS="$CFLAGS $(pkg-config --cflags libtirpc) -fPIC" LDFLAGS="$LD_FLAGS $(pkg-config --libs libtirpc)"
}

src_install() {
	emake prefix=${D}/usr libdir=${D}/usr/$(get_libdir) install
}

#src_install() {
#    insinto /usr/include
#    doins src/nvc.h
#    dobin nvidia-container-cli
#    insinto /usr/share/pkgconfig
#    doins usr/local/lib/pkgconfig/libnvidia-container.pc
#    dolib.a libnvidia-container.a
#    dolib.so libnvidia-container.so.${PV}
#    #dolib.so libnvidia-container.so.1
#}
