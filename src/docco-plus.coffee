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
# This ffi library allow us to call shell commands synchronously and
# can also be used to call other lower level C libraries.
# @see [https://github.com/rbranson/node-ffi](https://github.com/rbranson/node-ffi)
ffi      = require 'ffi'
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

    
    build_files: (dirs, languages) ->
        
        lang_filter = for ext of languages 
            " -name '*#{ext}' "
        lang_filter = lang_filter.join ' -o '
        cmd = "find #{dirs} #{lang_filter}"
        
        files = @sync_exec cmd
        files.split('\n').filter (file_name, index, array) -> 
            file_name != '' and path.basename(file_name) != '.'
        #console.log "DoccoPlus: Recursively generating documentation for # { roots } <- fix roots"
        



    # (syncExec)[https://github.com/mgutz/execSync] didn't work, so this is hacked from that
    sync_exec: (cmd) =>
        
        libc = ffi.Library(null, 
                # FILE* popen(char* cmd, char* mode);
                popen: ['pointer', ['string', 'string']],

                # void pclose(FILE* fp);
                pclose: ['void', [ 'pointer']],

                # char* fgets(char* buff, int buff, in)
                fgets: ['string', ['pointer', 'int','pointer']],

                system: ['int32', ['string']]
            )

        
        buffer = new Buffer 1024
        result = ''
        fp = libc.popen cmd, 'r'

        if (!fp) 
            throw new Error 'Error: Could not open command: ' + cmd

        while(libc.fgets(buffer, 1024, fp)) 
            result += buffer.readCString()
        
        libc.pclose(fp)

        return result


    
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
