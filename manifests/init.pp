# == Class: arecatools
#
#
# === Authors
#
# Author Name <hugo.vanduijn@naturalis.nl>
#
#
#
class arecatools(
  $extractpassword,
){
  file { "/opt/areca":
    ensure         => 'directory',
    mode           => '0755'
  }

  file {"/opt/areca/areca.zip":
    source        => "puppet:///modules/arecatools/areca.zip",
    ensure        => "present",
    require       => File['/opt/areca'],
  }

  exec {"unzip":
    command       => "/usr/bin/unzip -P ${extractpassword} /opt/areca/areca.zip -d /opt/areca",
    cwd           => "/opt/areca",
    unless        => "/usr/bin/test -f /opt/areca/cli64",
    require       => File["/opt/areca/areca.zip"],
  }

 file { "/opt/areca/cli64":
    ensure         => 'file',
    mode           => '0770',
    owner          => root,
    recurse        => true,
    require        => Exec['unzip']
  }

 file { "/opt/areca/archttp64":
    ensure         => 'file',
    mode           => '0770',
    owner          => root,
    recurse        => true,
    require        => Exec['unzip']
  }

}
