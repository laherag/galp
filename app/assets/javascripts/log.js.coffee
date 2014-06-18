class window.Log

  @is_dev_env: () ->
    gon.rails_env == 'development'

  #--------------------------------------------------------------------------------
  @i: (msg) ->
    if @is_dev_env
      console.info msg
  
  #--------------------------------------------------------------------------------
  @w: (msg) ->
    if @is_dev_env
      console.warn msg
  
  #--------------------------------------------------------------------------------
  @e: (msg) ->
    console.error msg