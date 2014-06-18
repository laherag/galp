$ ->
  # When everything is loaded, ClassRunner find which
  # class match current controller#action, instantiate it
  # and run it
  class window.ClassRunner

    run: () ->
      klass = ClassLoader.get(gon.current_script_uid)
      if typeof klass != "undefined"
        klass.main()

  classRunner = new ClassRunner
  classRunner.run()
