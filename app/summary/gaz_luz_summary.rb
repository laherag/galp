class GazLuzSummary < ContractSummary

  #--------------------------------------------------------------------------------
  def operation
    if @contract.no_confort?
      I18n.t('sum.operation.gaz_y_luz.no_confort', 
        cups_gaz: @contract.gaz_contract.cups_gas,
        cups_luz: @contract.luz_contract.cups_luz)
    else
      I18n.t('sum.operation.gaz_y_luz.confort', 
        cups_gaz: @contract.gaz_contract.cups_gas,
        cups_luz: @contract.luz_contract.cups_luz)
    end  
  end

  #--------------------------------------------------------------------------------
  def legal_agreement
    render_md I18n.t('sum.legal_agreement')
  end
end