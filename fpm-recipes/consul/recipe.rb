class Consul < FPM::Cookery::Recipe
  name 'consul'

  version '0.6.1'
  revision '1'
  description 'Consul Service Discovery Platform'

  homepage 'https://www.consul.io'
  source "https://releases.hashicorp.com/consul/#{version}/consul_#{version}_linux_amd64.zip"
  sha256 'dbb3c348fdb7cdfc03e5617956b243c594a399733afee323e69ef664cdadb1ac'

  maintainer 'Darron Froese <darron@froese.org>'
  vendor 'octohost'

  license 'Mozilla Public License, version 2.0'

  conflicts 'consul'
  replaces 'consul'

  build_depends 'unzip'

  def build
    safesystem "mkdir -p #{builddir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/consul_#{version}_linux_amd64/consul #{builddir}/usr/local/bin/"
  end

  def install
    safesystem "mkdir -p #{destdir}/usr/local/bin/"
    safesystem "cp -f #{builddir}/usr/local/bin/consul #{destdir}/usr/local/bin/consul"
    etc('init').install_p workdir('consul.upstart'), 'consul.conf'
    etc('default').install_p workdir('consul.default'), 'consul'
  end
end
