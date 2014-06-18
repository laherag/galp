# CLassLoader is supposed to load all the class 
# so that we can easily find and instantiate any class
# from basically anywhere (ClassLoader is a singleton)
class window.ClassLoader
  instance = null
  
  class ClassesContainer
    constructor: (@classes = {}) ->
    
    add: (name, klass) ->
      @classes[name] = klass

    all: () ->
      @classes

    get: (name) ->
      @classes[name]

  @add: (name, klass) ->
    instance ?= new ClassesContainer
    instance.add(name, klass)
    Log.i "add -> #{name}"

  @all: () ->
    instance.all()

  @get: (name) ->
    controller = instance.get(name)
    if ! controller
      Log.w "controller for #{name} not found"
    controller
      

