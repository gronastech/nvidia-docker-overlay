# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

DESCRIPTION="nvidia-container-toolkit OCI hook invoked by runc"
HOMEPAGE="https://github.com/NVIDIA"
KEYWORDS="*"

LICENSE="Apache-2.0"
SLOT="0"

DEPEND=">=dev-lang/go-1.15:="
RDEPEND="virtual/libnvidia-container
	!<app-containers/nvidia-container-runtime-3.5.0"

TARBALL_PV=${PV}

NV_GITHUB_TOOLKIT_REPO="nvidia-container-toolkit"
NV_GITHUB_USER="NVIDIA"
NV_GITHUB_TAG="v${PV}"

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1 h1:WXkYYl6Yr3qBf1K79EBnL4mak0OimBfB0XUf9Vl28OQ="
	"github.com/BurntSushi/toml v0.3.1/go.mod h1:xHWCNGjB5oqiDr8zfno3MHue2Ht5sIBksp03qcyfWMU="
	"github.com/davecgh/go-spew v1.1.0 h1:ZDRjVQ15GmhC3fiQ8ni8+OwkZQO4DARzQgrnXU1Liz8="
	"github.com/davecgh/go-spew v1.1.0/go.mod h1:J7Y8YcW2NihsgmVo/mv3lAwl/skON4iLHjSsI+c5H38="
	"github.com/pmezard/go-difflib v1.0.0 h1:4DBwDE0NGyQoBHbLQYPwSUPoCMWR5BEzIk/f1lZbAQM="
	"github.com/pmezard/go-difflib v1.0.0/go.mod h1:iKH77koFhYxTK1pcRnkKkqfTogsbg7gZNVY4sRDYZ/4="
	"github.com/stretchr/objx v0.1.0/go.mod h1:HFkY916IF+rwdDfMAkV7OtwuqBVzrE8GR6GFx+wExME="
	"github.com/stretchr/testify v1.6.0 h1:jlIyCplCJFULU/01vCkhKuTyc3OorI3bJFuw6obfgho="
	"github.com/stretchr/testify v1.6.0/go.mod h1:6Fq8oRcR53rry900zMqJjRRixrwX3KX962/h/Wwjteg="
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod h1:djNgcEr1/C05ACkg1iLfiJU5Ep61QUkGW8qpdssI0+w="
	"golang.org/x/crypto v0.0.0-20191011191535-87dc89f01550/go.mod h1:yigFU9vqHzYiE8UmvKecakEJjdnWj3jj499lnFckfCI="
	"golang.org/x/mod v0.3.0 h1:RM4zey1++hCTbCVQfnWeKs9/IEsaBLA8vTkd0WVtmH4="
	"golang.org/x/mod v0.3.0/go.mod h1:s0Qsj1ACt9ePp/hMypM3fl4fZqREWJwdYDEqhRiZZUA="
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod h1:t9HGtf8HONx5eT2rtn7q6eTqICYqUVnKs3thJo3Qplg="
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod h1:z5CRVTTTmAJ677TzLLGU+0bjPO0LkuOLi4/5GtJWs/s="
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod h1:RxMgew5VJxzue5/jJTE5uejpjVlOe/izrB70Jof72aM="
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod h1:STP8DvDyc/dI5b8T5hshtkjS+E42TnysNCUPdjciGhY="
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod h1:h1NjWce9XRLGQEsW7wpKNCjG9DtNlClVuFLEZdDNbEs="
	"golang.org/x/text v0.3.0/go.mod h1:NqM8EUOU14njkJ3fqMW+pc6Ldnwhi/IjpwHt7yyuwOQ="
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod h1:b+2E5dAYhXwXZwtnZ6UAqBI28+e2cm9otk0dWdXHAEo="
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0="
	"golang.org/x/xerrors v0.0.0-20191011141410-1b5146add898/go.mod h1:I/5z698sn9Ka8TeJc9MKroUUfqBBauWjQqLJ2OPfmY0="
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod h1:Co6ibVJAznAaIkqp8huTwlJQCZ016jof/cbN4VW5Yz0="
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c h1:dUUwHk2QECo/6vqA44rthZ8ie2QXMNeKRTHCNY2nXvo="
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod h1:K4uyk7z7BCEPqu6E+C64Yfv1cQ7kz7rIZviUmN+EgEM="
)

go-module_set_globals

SRC_URI="
	https://www.github.com/${NV_GITHUB_USER}/${NV_GITHUB_TOOLKIT_REPO}/archive/v${PV}.tar.gz -> ${NV_GITHUB_TOOLKIT_REPO}-${PV}.tar.gz
	${EGO_SUM_SRC_URI}
"

src_compile() {
	go build -ldflags "-s -w" -o "nvidia-container-toolkit" github.com/NVIDIA/nvidia-container-toolkit/pkg
}

src_install() {
	dobin nvidia-container-toolkit
	dosym nvidia-container-toolkit /usr/bin/nvidia-container-runtime-hook
	insinto /etc/nvidia-container-runtime
	# The openSUSE config happens to have the correct settings for Gentoo
	# (mainly the root:video user settings)
	# so install this config as default
	newins config/config.toml.opensuse-leap config.toml
	dodir /usr/libexec/oci/hooks.d
	exeinto /usr/libexec/oci/hooks.d
	doexe oci-nvidia-hook
	dobin oci-nvidia-hook
	dodir /usr/share/containers/oci/hooks.d
	insinto /usr/share/containers/oci/hooks.d
	doins oci-nvidia-hook.json
}
