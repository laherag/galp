$ ->
  # convert all input date to jquery date picker
  $.datepicker.setDefaults
    dateFormat: 'dd-mm-yy'

  $(".datepicker").datepicker()

  set_date = (date) ->
    if date.length > 0
      date = date.slice(0,10).split('-')
      new Date(date[0], date[1] - 1, date[2])

  for datepicker in $(".datepicker")
    raw_date = $(datepicker).val()
    date = set_date(raw_date)
    $(datepicker).datepicker('setDate', date)

