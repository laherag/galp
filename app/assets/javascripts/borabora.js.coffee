# Borabora is the class that should be extended by all
# javascript class controller, it provides the basic features
# so that a class can be automatically run  
class window.BoraBora

  constructor: () ->
    console.log @constructor.name
    ClassLoader.add(@constructor.name, this)

  is_current_script: () ->
    gon.current_script_uid == @constructor.name

  main: () ->
    Log.i "run main -> #{@constructor.name}"
