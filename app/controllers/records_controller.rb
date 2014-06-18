class RecordsController < SignedInController

  expose(:contract)
  
  #--------------------------------------------------------------------------------
  def new
    unless contract.cig.present?
      set_fecha_venta()
      set_stat()
      set_cig()
    end
    
    @record = Record.new
  end

  #--------------------------------------------------------------------------------
  def set_stat
    stat = current_user.stats.today
    stat.update(nb_contracts: stat.nb_contracts + 1)
  end

  #--------------------------------------------------------------------------------
  def set_fecha_venta
    contract.update(fecha_venta: Time.now)
  end

  #--------------------------------------------------------------------------------
  def set_cig  
    contract.update(cig: contract.generate_cig(current_user))
  end

  #--------------------------------------------------------------------------------
  def upload
    # once a record have been uploaded, we want the contract to be in the csv
    contract.update(state: 'csv_ready')

=begin
    # uncomment to make the upload work
    record_params.merge!({ 'contract_id' => contract.id })
    @record = Record.create(record_params)

    @record.contract = contract
    @record.save!
=end
 
    redirect_to controller: :contracts
  end

  private

  #--------------------------------------------------------------------------------
  def record_params
    params.require(:record).permit!
  end
end
