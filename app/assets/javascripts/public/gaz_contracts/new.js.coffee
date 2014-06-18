class GazContractsNew extends BoraBora

  CAMBIO_TITULAR_CONT = $('#contract_gaz_contract_attributes_cambio_de_titular')
  APELLIDO_CONT = $('#contract_gaz_contract_attributes_apellido_antiguo_titular_gas')
  NOMBRE_CONT = $('#contract_gaz_contract_attributes_nombre_antiguo_titular_gas')
  DNI_ANTIGUO_TITULAR_CONT = $('#contract_gaz_contract_attributes_dni_gas')
  
  #--------------------------------------------------------------------------------
  constructor: () ->
    super


  #--------------------------------------------------------------------------------
  main: () ->
    super

  
  #--------------------------------------------------------------------------------
  bind_gaz_options: () ->
    klass = this
    CAMBIO_TITULAR_CONT.change () ->
      klass.toggle_gaz_options()    

    klass.toggle_gaz_options()

  #--------------------------------------------------------------------------------
  toggle_gaz_options: () ->
    klass = this

    mismo_titular = ! CAMBIO_TITULAR_CONT.is(':checked')
    APELLIDO_CONT.prop('readonly', mismo_titular)
    NOMBRE_CONT.prop('readonly', mismo_titular)
    DNI_ANTIGUO_TITULAR_CONT.prop('readonly', mismo_titular)  


new GazContractsNew