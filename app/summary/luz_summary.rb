class LuzSummary < ContractSummary

  #--------------------------------------------------------------------------------
  def operation
    if @contract.no_confort?
      I18n.t('sum.operation.luz.no_confort', cups_luz: @contract.luz_contract.cups_luz)
    else
      I18n.t('sum.operation.luz.confort', cups_luz: @contract.luz_contract.cups_luz)
    end  
  end
end