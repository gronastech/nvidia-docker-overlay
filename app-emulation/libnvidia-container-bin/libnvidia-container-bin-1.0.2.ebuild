# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="NVIDIA container runtime library and nvidia-container-cli tool"
HOMEPAGE="https://github.com/NVIDIA/libnvidia-container"
SRC_URI="https://github.com/NVIDIA/libnvidia-container/releases/download/v1.0.2/libnvidia-container_1.0.2_amd64.tar.xz"
LICENSE="NVIDIA"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
    net-libs/libtirpc
    sys-libs/libcap
    sys-libs/libseccomp"

S=${WORKDIR}/libnvidia-container_${PV}

QA_PREBUILT="/usr/bin/nvidia-container-cli"
QA_PRESTRIPPED="/usr/bin/nvidia-container-cli"
QA_PRESTRIPPED="/usr/lib64/libnvidia-container.so.*"

src_install() {
    insinto /usr/include
    doins usr/local/include/nvc.h
    dobin usr/local/bin/nvidia-container-cli
    insinto /usr/share/pkgconfig
    doins usr/local/lib/pkgconfig/libnvidia-container.pc
    dolib.a usr/local/lib/libnvidia-container.a
    dolib.so usr/local/lib/libnvidia-container.so.${PV}
    dolib.so usr/local/lib/libnvidia-container.so.1
    # This script loads necessary module and performs some initialization steps.
    newinitd $FILESDIR/nvidia-container.initd nvidia-container
}
