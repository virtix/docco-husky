#
# This tests the Docco parser and language pack
#
#
# @author bill@if.io
# @version 0.9
#
#
path = require 'path'
assert = require 'assert'
languages = require('./../lib/languages').languages()
dp = require './../lib/docco-plus'


docco = {}
parser = {}
utils = {}

# -------------------------------

suite "Spike", ->
    test 'figure out for N of iterable', ->
        #for ext of languages
        #    console.log ext
        for key,lang of languages
            key + ' = ' + lang.name

suite 'Utils Tests', ->
   
    test 'Build a list of files from languages in the current working directory', ->
        filter = []

        #!console.log Object.keys(languages).join(' -name -o ')
        lang_filter = for ext of languages 
            " -name '*#{ext}' "
        lang_filter = lang_filter.join ' -o '
        #console.log lang_filter


    test 'Given a non-exitent file extension, this should throw an exception', ->
        ext = 'file.ZZZZZ'
        try
          utils.get_language ext, languages
          console.log 'should not get here'
        catch e
            #console.log e

    test 'Given a file extension, returns the language type object', ->
        paths = [ 
            ['/foo/bar.js', 'javascript'], 
            ['/bar/etc/nanoo.py', 'python'], 
            ['gepetto.pp','ruby'], 
            ['.ssh/one.r', 'r'],
            ['two.R', 'r'], 
            ['/home/baz/%20\ouch.bf', 'brainfuck'] ,
            ['asd/lkasdASD/lkasd___.clj', 'clojure'],
            ['asd.c' , 'c'],
            ['____0asdasdJASkjhb.asd/asdas,.,asd/lklasdu.php', 'php'],
            ['/d/f/g/h/j/k/q/w/e/r/t/y/u/i/o/coffee.coffee','coffee-script']
        ]
        
        for p in paths
            lang = utils.get_language p[0], languages
            assert.equal lang, p[1]
        
    
    test 'Utils class should be alive', ->
        assert utils != null
    
    test 'Test file_exists method', ->
        p = path.resolve '../package.json'
        assert utils.file_exists p
    
    test "Ensure that the output destination directory exists; e.g., ./test/fixtures", ->
        dir = path.resolve './fixtures'
        _callback = ->
            'ok'
        retval = utils.ensure_directory  dir, _callback
        assert.equal retval, 'ok'
        

# -------------------------------------
suite 'Docco-plus Parser Tests', ->
    
    test 'Docco-plus should be alive', ->
        assert docco.get_version() == '0.9', docco.get_version()





# -------------------------------------
suite 'Language Tests', ->
    test 'languages() should return an object.', ->
        assert typeof languages == 'object'
    test 'We want to make sure there are at least 10 languages (but there should be many more)', ->
        assert Object.keys(languages).length > 10




# Set up
before ->
    docco = new dp.DoccoPlus
    parser = new dp.Parser
    utils = new dp.Utils


after ->
    docco = {}
    parser = {}
    utils = {}




