class ContractsNew extends BoraBora
 
  #--------------------------------------------------------------------------------
  constructor: () ->
    super

  #--------------------------------------------------------------------------------
  main: () ->
    super
    @bind_fields()
    @bind_titular_final_input()
    @bind_type_of_contract_switch()
    @bind_confort_input()

    @cities_controller = ClassLoader.get("CitiesShow")
    @cities_controller.bind_city_selection()

    @gaz_controller = ClassLoader.get("GazContractsNew")
    @gaz_controller.bind_gaz_options()
    
    @luz_controller = ClassLoader.get("LuzContractsNew")
    @luz_controller.bind_luz_options()

    @bind_tipo_potencia()
    @bind_save_temporary_button()

  GAZ_AND_LUZ_CONTRACT = 'gas_y_luz'
  GAZ_CONTRACT = 'gas'

  CONTRACT_TYPE_CONT = $('#contract_tipo')
  
  GAZ_CONTRACT_CONT = $('#gaz-form')
  LUZ_CONTRACT_CONT = $('#luz-form')

  TIPO_GAZ = $('#contract_gaz_contract_attributes_tipo_gas')
  TIPO_LUZ = $('#contract_luz_contract_attributes_tipo_luz')
  
  EMAIL = $('#contract_email')

  SAVE_TEMPORARY_BTN = $('#save-temporary')

  MARCA_CALDERA_CONT = $('.contract_marca_caldera')

  CONFORT_ID_CONT = $('#contract_confort')

  TIPO_POTENCIA = $('#contract_luz_contract_attributes_tipo_potencia')
  CAMBIO_POTENCIA = $('#contract_luz_contract_attributes_cambio_potencia')

  NOMBRE_CONT = $('#contract_nombre')
  APELLIDO_CONT = $('#contract_apellido')
  DNI_TITULAR_FINAL_CONT = $('#contract_dni_titular_final')
  TITULAR_FINAL_CONT = $('#contract_titular_final')

  # a field is updated according to its binded field.
  input_binded_fields = [
    { 
      '#contract_apellido' : [
        '#contract_gaz_contract_attributes_apellido_antiguo_titular_gas'
        '#contract_luz_contract_attributes_apellido_antiguo_titular_luz'
      ]
    }, {
      '#contract_nombre' : [
        '#contract_gaz_contract_attributes_nombre_antiguo_titular_gas'
        '#contract_luz_contract_attributes_nombre_antiguo_titular_luz'
      ]
    }, {
      '#contract_dni_titular_final' : [
        '#contract_gaz_contract_attributes_dni_gas'
        '#contract_luz_contract_attributes_dni_luz'
      ]
    }, {
      '#contract_gaz_contract_attributes_apellido_antiguo_titular_gas' : [
        '#contract_luz_contract_attributes_apellido_antiguo_titular_luz'
      ]
    }, {
      '#contract_gaz_contract_attributes_nombre_antiguo_titular_gas' : [
        '#contract_luz_contract_attributes_nombre_antiguo_titular_luz'
      ]
    }
  ]

  #--------------------------------------------------------------------------------
  bind_type_of_contract_switch: () ->
    that = this
    CONTRACT_TYPE_CONT.change () ->
      contract_type = CONTRACT_TYPE_CONT.val()
      switch contract_type
        when GAZ_CONTRACT
          that.toggle_form(LUZ_CONTRACT_CONT, false)
          that.toggle_form(GAZ_CONTRACT_CONT, true)
          
          if that.gaz_controller
            that.gaz_controller.bind_gaz_options()
        else
          that.toggle_form(LUZ_CONTRACT_CONT, true)
          that.toggle_form(GAZ_CONTRACT_CONT, true)

          if that.gaz_controller
            that.gaz_controller.bind_gaz_options()
          if that.luz_controller
            that.luz_controller.bind_luz_options()
    
      that.toggle_marca_caldera()
      that.force_choose_tipo(contract_type)

    CONTRACT_TYPE_CONT.change()    

  #--------------------------------------------------------------------------------
  toggle_form: (container, enable) ->
    container.find('input').prop('disabled', ! enable)
    if enable
      container.show()
    else
      container.hide()

    inputs = container.find(':input')
    inputs.prop('disabled', ! enable)

  #--------------------------------------------------------------------------------
  toggle_marca_caldera: () ->
    work = CONFORT_ID_CONT.val()
    marca_caldera_visible = (work != 'no')

    if marca_caldera_visible
      MARCA_CALDERA_CONT.show() 
      MARCA_CALDERA_CONT.prop('disabled', false)
    else
      MARCA_CALDERA_CONT.hide()
      MARCA_CALDERA_CONT.prop('disabled', true)

  #--------------------------------------------------------------------------------
  bind_confort_input: () ->
    that = this
    CONFORT_ID_CONT.change () ->
      that.toggle_marca_caldera()

  #--------------------------------------------------------------------------------
  bind_titular_final_input: () ->
    that = this
    NOMBRE_CONT.bind 'input', ->
      that.update_titular_final()
    APELLIDO_CONT.bind 'input', ->
      that.update_titular_final()
    DNI_TITULAR_FINAL_CONT.bind 'input', ->
      that.update_titular_final()
  
  #--------------------------------------------------------------------------------
  force_choose_tipo: (tipo) ->
    if tipo is GAZ_CONTRACT
      TIPO_GAZ.prop('required', true)
      TIPO_LUZ.prop('required', false)
    else
      TIPO_LUZ.prop('required', true)
      TIPO_GAZ.prop('required', true)
    
  
  #--------------------------------------------------------------------------------
  update_titular_final: () ->
    nombre = NOMBRE_CONT.val()
    apellido = APELLIDO_CONT.val()
    dni_titular_final = DNI_TITULAR_FINAL_CONT.val()
    TITULAR_FINAL_CONT.val("#{nombre} #{apellido} #{dni_titular_final}")

  #--------------------------------------------------------------------------------
  bind_tipo_potencia: () ->
    CAMBIO_POTENCIA.change () ->
      is_cambio_potencia = CAMBIO_POTENCIA.is(':checked')
      TIPO_POTENCIA.prop("disabled", ! is_cambio_potencia)
    CAMBIO_POTENCIA.change()

  #--------------------------------------------------------------------------------
  bind_save_temporary_button: () ->
    SAVE_TEMPORARY_BTN.bind "click", () ->
      for form in document.forms
        form.setAttribute "novalidate", ""

  #--------------------------------------------------------------------------------
  bind_inputs: (field1, field2) ->
    if $(field1).val() == $(field2).val()
      $(field1).bind 'input', ->
        $(field2).val($(field1).val())

  #--------------------------------------------------------------------------------
  unbind_inputs: (field1, field2) ->
    $(field2).bind 'input', ->
      $(field1).unbind('input')

  #--------------------------------------------------------------------------------
  bind_fields: () ->
    for h in input_binded_fields
      for source, values of h
        for value in values
          @unbind_inputs(source, value)
          @bind_inputs(source, value)


new ContractsNew