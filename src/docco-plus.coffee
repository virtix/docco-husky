# -----------------------------------------------------------------------
#     Documentation generator based on Docco and Docco-husky
#
#     @author bill@if.io
#     @date 02.18.13
# -----------------------------------------------------------------------
fs       = require 'fs'
path     = require 'path'
showdown = require('./../vendor/showdown').Showdown
jade     = require 'jade'
dox      = require 'dox'
gravatar = require 'gravatar'
_        = require 'underscore'
walk     = require 'walk'
{spawn, exec} = require 'child_process'
# Import the language definitions. Add or update recognized languages there.
# See [Pygments](http://pygments.org)
# To do: Make adding of additional languages possible on the comand-line
languages = require('./../lib/languages').languages()


class DoccoPlus
   
    _version = '0.9'
    
    get_version: ->
        _version


        
# --------------------------------------------
#      Placeholder for Parser class
# --------------------------------------------
class Parser

    get_parser: ->
        this




# --------------------------------------------
#      Placeholder for Utils class
# --------------------------------------------
class Utils

    #
    # Returns the language definition given a file path.
    #
    # @param path string
    # @param languages Object (hashmap)
    #
    get_language: (source_path,languages) ->
        ext  = path.extname(source_path)
        for key,lang of languages
            key_array = key.split ','
            for k in key_array
                if k == ext
                    return lang.name

        throw new Error 'No language found for extension: ' + ext



    # 
    # Make sure the output directory is created
    #
    ensure_directory: (dir,callback) ->
        exec 'mkdir -p dir'
        callback()
     


    #
    # Simple existence check
    #
    file_exists: (path) ->
        try 
            return fs.lstatSync(path).isFile
        catch ex
            return false


module.exports.DoccoPlus = DoccoPlus
module.exports.Parser = Parser
module.exports.Utils = Utils
