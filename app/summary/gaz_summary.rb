class GazSummary < ContractSummary

  #--------------------------------------------------------------------------------
  def operation
    if @contract.no_confort?
      I18n.t('sum.operation.gaz.no_confort', cups_gaz: @contract.gaz_contract.cups_gas)
    else
      I18n.t('sum.operation.gaz.confort', cups_gaz: @contract.gaz_contract.cups_gas)
    end  
  end

  #--------------------------------------------------------------------------------
  def legal_agreement
    render_md I18n.t('sum.legal_agreement')
  end
end