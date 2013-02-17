#
# Additional languages can be added here and need to be one of the [supported Pygments languages](http://pygments.org/languages/).
# To add a language, edit ```languages.coffee```, run ```cake build```, and reinstall package
#
  

  exports.languages = ->
      '.coffee':
        name: 'coffee-script', symbol: '#'
    
      '.js':
        name: 'javascript', symbol: '//', multi_start: '/*', multi_end: '*/'
      
      '.rb':
        name: 'ruby', symbol: '#'
      
      '.py':
        name: 'python', symbol: '#'
      
      '.java':
        name: 'java', symbol: '//', multi_start: '/*', multi_end: '*/'
    
    # Puppet modules, which are a Ruby DSL
      '.pp':
        name: 'ruby', symbol: '#', multi_start: '/*', multi_end: '*/'
    
    # Puppet manifest and other conf files
      '.conf':
        name: 'bash', symbol: '#'
    
      '.c':
        name: 'c', symbol: '//', multi_start: '/*', multi_end: '*/' 
    
      '.clj':
        name: 'clojure', symbol: ';', multi_start: '(comment', multi_end: ')'
    
      '.bf':
        name: 'brainfuck', symbol: '#'

      '.php':
        name: 'php', symbol: '//', multi_start: '/*', multi_end: '*/'


