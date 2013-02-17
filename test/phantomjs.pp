class phantomjs {

#Module variables, only one that should ever be changed is version.
$version = '1.5.0'
$arch = 'x86_64'
$sourcefile = "phantomjs-${version}-linux-${arch}-dynamic.tar.gz"
$phantom_src_path = "/usr/local/src/phantomjs-${version}/"
$phantom_bin_path = '/opt/phantomjs/'

#Lets create the directory where phantom source will use
file { "$phantom_src_path" : ensure => directory }

#Lets download the source code for phantom
exec { "download-${sourcefile}":
  command => "/usr/bin/wget http://phantomjs.googlecode.com/files/${sourcefile} -O /tmp/${sourcefile}",
  cwd     => "${phantom_src_path}",
  creates => "${phantom_src_path}${sourcefile}",
  require => File["$phantom_src_path"]
  }

#Lets extract the source code
exec { "extract-${sourcefile}":
  command => "/bin/tar -xvfz ${sourcefile} -C /opt/",
  creates => '/opt/phantomjs/',
  cwd     => "${phantom_src_path}",
  require => Exec["download-${sourcefile}"],
  }

#Make symlink from source to working directory
file { '/usr/local/bin/phantomjs':
  ensure  => link,
  target  => "${phantom_bin_path}/bin/phantomjs",
  require => Exec["extract-${sourcefile}"],
  }

#More links
file { '/usr/bin/phantomjs':
  ensure  => link,
  target  => "${phantom_bin_path}/bin/phantomjs",
  require => Exec["extract-${sourcefile}"],
  }

#This will be executed IF the version installed is not the same as the $version
#variable at the top of module
#exec { 'phantom-upgrade':
#  command => 'rm -Rf /opt/phantomjs /usr/local/bin/phantomjs',
#  unless  => "test -f /usr/local/bin/phantomjs && /usr/local/bin/phantomjs --version | grep ${version}",
#  before  => Exec["download-${sourcefile}"]
#  }
}
