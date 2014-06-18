class CitiesShow extends BoraBora

  ZIP_CODE_CONT = $('#contract_zip_code')
  WORK_ID_CONT = $('#contract_confort')
  ZIP_CODE_ERROR = $('#zip_code_not_available')

  # zip code starting with these two digits have 'work' enabled
  WORK_ENABLED_FOR_ZIP_CODES = "03 08 12 15 27 28 32 33 36 39 43 46".split(' ')
  CONTRACT_DISABLED_FOR_ZIP_CODES = []# "".split(' ')

  #--------------------------------------------------------------------------------
  constructor: () ->
    super

  #--------------------------------------------------------------------------------
  main: () ->
    super

  #--------------------------------------------------------------------------------
  bind_city_selection: () ->
    that = this

    # bind to city name
    ZIP_CODE_CONT.on 'input', () ->
      zip_code = ZIP_CODE_CONT.val()
      that.set_work(zip_code)
      that.check_contract_possible_for_city(zip_code)

    # trigger function (usefull when redirect_to same page)
    that.set_work(ZIP_CODE_CONT.val())


  # depending on the given zip code, enable/disable work input
  #--------------------------------------------------------------------------------
  set_work: (zip_code) ->
    first_two_digits = zip_code.substring(0, 2)
    work_disabled = (WORK_ENABLED_FOR_ZIP_CODES.indexOf(first_two_digits) == -1)
    WORK_ID_CONT.prop('disabled', work_disabled);
    if work_disabled
      WORK_ID_CONT.val('no')

  check_contract_possible_for_city: (zip_code) ->
    first_two_digits = zip_code.substring(0, 2)
    contract_impossible = (CONTRACT_DISABLED_FOR_ZIP_CODES.indexOf(first_two_digits) != -1)
    if contract_impossible
      ZIP_CODE_ERROR.show()
    else
      ZIP_CODE_ERROR.hide()


new CitiesShow 