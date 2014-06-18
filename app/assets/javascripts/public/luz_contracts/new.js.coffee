class LuzContractsNew extends BoraBora

  LUZ_OPTIONS_CONT = $('#luz-options')
  TIPO_LUZ_CONT = $('#contract_luz_contract_attributes_tipo_luz')
  CERTIFICATED_CONT = $('#contract_luz_contract_attributes_certificado')
  CAMBIO_TITULAR_CONT = $('#contract_luz_contract_attributes_cambio_de_titular')
  APELLIDO_CONT = $('#contract_luz_contract_attributes_apellido_antiguo_titular_luz')
  NOMBRE_CONT = $('#contract_luz_contract_attributes_nombre_antiguo_titular_luz')
  DNI_ANTIGUO_TITULAR_CONT = $('#contract_luz_contract_attributes_dni_luz')
  NUEVO_SUMINISTRO = 'ad_nuevo_suministro'
  
  #--------------------------------------------------------------------------------
  constructor: () ->
    super


  #--------------------------------------------------------------------------------
  main: () ->
    super

  
  #--------------------------------------------------------------------------------
  bind_luz_options: () ->
    klass = this

    CAMBIO_TITULAR_CONT.change () ->
      klass.toggle_luz_persona_informaciones()    

    TIPO_LUZ_CONT.change () ->
      klass.toggle_luz_options()

    CERTIFICATED_CONT.change () ->
      klass.toggle_luz_options()      

    klass.toggle_luz_options()
    klass.toggle_luz_persona_informaciones()

  #--------------------------------------------------------------------------------
  toggle_luz_persona_informaciones: () ->
    mismo_titular = ! CAMBIO_TITULAR_CONT.is(':checked')
    APELLIDO_CONT.prop('readonly', mismo_titular)
    NOMBRE_CONT.prop('readonly', mismo_titular)
    DNI_ANTIGUO_TITULAR_CONT.prop('readonly', mismo_titular)
  
  #--------------------------------------------------------------------------------
  toggle_luz_options: () ->
    klass = this
    tipo_luz = TIPO_LUZ_CONT.val()
    is_certificated = CERTIFICATED_CONT.is(':checked')
    if (tipo_luz is NUEVO_SUMINISTRO or is_certificated)
      LUZ_OPTIONS_CONT.show()
      klass.enable_inputs(true, LUZ_OPTIONS_CONT)
    else
      LUZ_OPTIONS_CONT.hide()
      klass.enable_inputs(false, LUZ_OPTIONS_CONT)


  # disable/enable all inputs for a container
  #--------------------------------------------------------------------------------
  enable_inputs: (enable, cont) ->
    inputs = cont.find(':input')
    inputs.prop("disabled", ! enable)

new LuzContractsNew