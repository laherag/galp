class ContractsUpdate extends BoraBora

  #--------------------------------------------------------------------------------
  main: () ->
    super

  #--------------------------------------------------------------------------------
  constructor: () ->
    super

  #--------------------------------------------------------------------------------
  update_galp_status: (contract_id, new_status) ->
    $.ajax
      url: "/contracts/#{contract_id}/update_status"
      type: "PUT"
      data:
        status: new_status
    $.notify("estado cambió es #{new_status}", "success");

new ContractsUpdate


#--------------------------------------------------------------------------------
window.update_galp_status = (contract_id, new_status) ->
  controller = ClassLoader.get('ContractsUpdate')
  controller.update_galp_status(contract_id, new_status)
