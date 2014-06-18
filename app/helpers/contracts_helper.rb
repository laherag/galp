module ContractsHelper

  IGNORED_ATTRIBUTES = %w[id updated_at contract_id]

  # do not show blank attributes and attributes present in the 'ignore list attributes'
  #--------------------------------------------------------------------------------
  def visible_attributes(contract)
    contract.attributes.map do |k, v|
      if v and ! v.blank? and ! IGNORED_ATTRIBUTES.include?(k) 
        { k => v }
      end
    end.compact
  end
end
