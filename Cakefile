{spawn, exec} = require 'child_process'

option '-p', '--prefix [DIR]', 'set the installation prefix for `cake install`'

task 'clean', 'removes generated files and should be run prior to doc task', ->
  exec([
    'rm -rf docs/*'
  ])

task 'build', 'continually build the docco library with --watch', ->
  coffee = spawn 'coffee', ['-cw', '-o', 'lib', 'src']
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()

task 'install', 'install the `docco-husky` command into /usr/local (or --prefix)', (options) ->
  base = options.prefix or '/usr/local/share'
  lib  = base + '/lib/node-modules/docco-husky'
  exec([
    'mkdir -p ' + lib
    'cp -rf bin README.md resources vendor lib ' + lib
    'ln -sf ' + lib + '/bin/generate ' + base + '/npm/bin/docco-husky'
  ].join(' && '), (err, stdout, stderr) ->
   if err then console.error stderr
  )

task 'doc', 'rebuild the Docco documentation', ->
  exec([
    'bin/generate src/docco.coffee src/languages.coffee'
    'sed "s/docco.css/resources\\/docco.css/" < docs/docco.html > index.html'
    'rm -r docs'
  ].join(' && '), (err) ->
    throw err if err
  )

task 'test', 'test the doc generator', ->
  exec([
    'rm -rf test/docs'
    'cd test'
    '../bin/generate .'
  ].join(' && '), (err) ->
    throw err if err
  )
