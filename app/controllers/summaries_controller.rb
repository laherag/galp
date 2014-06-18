class SummariesController < SignedInController
  
  expose(:contract)
  expose(:decorated_contract) { ContractDecorator.decorate(contract) }

  #--------------------------------------------------------------------------------
  def show
    

    @summary = case contract.tipo
    when Contract.tipo.find_value(:gas)
      GazSummary.new(decorated_contract)
    when Contract.tipo.find_value(:luz)
      LuzSummary.new(decorated_contract)
    else
      GazLuzSummary.new(decorated_contract)
    end
  end  
end
