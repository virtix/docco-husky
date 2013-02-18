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



suite 'Utils tests', ->
    test 'Utils class should be alive', ->
        assert utils != null
    test 'Test file_exists method', ->
        p = path.resolve '../package.json'
        assert utils.file_exists p
    test "Ensure that the output destination directory exists; e.g., ./test", ->
        dir = path.resolve './fixtures'
        #console.log dir
        _callback = ->
            'ok'
        retval = utils.ensure_directory dir,_callback
        assert.equal retval, 'ok'
        


suite 'Docco-plus parser tests', ->
    
    test 'Docco-plus should be alive', ->
        assert docco.get_version() == '0.9', docco.get_version()




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




