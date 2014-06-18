require 'csv'
require 'yaml'

class ContractsController < SignedInController

  CSV_CONF_PATH = Rails.root.join('config', 'initializers', 'csv_headers.yml')
  
  before_action :filter_contracts
  
  expose(:formated_params) { format_params(params[:q]) if params[:q] }
  expose(:searched_contracts) { Contract.sorted.includes(:teleop).search(formated_params) }
  expose(:contracts) { 
    scs = searched_contracts.result 
    galp_status_filter = params[:q].try(:[], 'galp_status_cont_any').present?
    galp_status_filter = galp_status_filter || params[:all_statuses].present?

    if current_user.admin
      if galp_status_filter
        scs
      else
        scs.without_galp_status
      end
    else
      scs
    end
  }
  expose(:paginated_contracts)  { contracts.page(params[:page]) }

  expose(:cambios_contracts) { contracts.with_moving_type(:cambio) }
  expose(:altas_contracts)   { contracts.with_moving_type(:alta, :alta_y_cambio) }

  expose(:contract_form)       { ContractForm.new(contract) }
  expose(:decorated_contract)  { ContractDecorator.decorate(contract) }

  expose(:contract) {
    if params[:id]
      contract = Contract.find(params[:id])
      contract.build_gaz_contract unless contract.gaz_contract
      contract.build_luz_contract unless contract.luz_contract
      contract
    else
      builded_contract()
    end
  }

  #--------------------------------------------------------------------------------  
  def format_params(params)
    # these variables will be displayed in the search form, let's make them pretty
    created_at_gteq = params[:created_at_gteq]
    created_at_gteq = DateUtil.date_from_string(created_at_gteq)

    created_at_lteq = params[:created_at_lteq]
    created_at_lteq = DateUtil.date_from_string(created_at_lteq)
    
    # upper bound should always be set at the end of the day
    if ! params[:created_at_lteq].blank?
      params[:created_at_lteq] = params[:created_at_lteq].to_date.end_of_day 
    end

    params
  end

  #--------------------------------------------------------------------------------  
  def filter_contracts
    specific_contract_searched = params[:q] && 
      (! params[:q][:apellido_cont].blank? || ! params[:q][:nombre_cont].blank?)

    unless current_user.admin or current_user.galp or specific_contract_searched
      self.contracts = self.contracts.belongs_to(current_user.id)
    end
  end

  #--------------------------------------------------------------------------------  
  def index
    self.contracts = contracts.with_state(:completed, :csv_ready)
    render_or_export()
  end

  #--------------------------------------------------------------------------------
  def render_or_export
    if params[:csv]
      send_data(csv_contracts(contracts), filename: 'selectra_contracts.csv')    
    else
      set_current_script_uid("Index")
      render :index
    end
  end

  #--------------------------------------------------------------------------------
  def cambios
    self.contracts = cambios_contracts.with_state(:completed, :csv_ready)
    render_or_export()
  end

  #--------------------------------------------------------------------------------
  def altas
    self.contracts = altas_contracts.with_state(:completed, :csv_ready)
    render_or_export()
  end

  #--------------------------------------------------------------------------------  
  def uncompleted
    self.contracts = contracts.with_state(:uncompleted)
    set_current_script_uid("Index")
    
    render :uncompleted_index
  end
  
  #--------------------------------------------------------------------------------  
  def update
    if params[:uncompleted]
      save_uncompleted()
    else
      save_completed()
    end
  end

  #--------------------------------------------------------------------------------  
  def create
    if params[:uncompleted]
      save_uncompleted()
    else
      save_completed()
    end
  end

  #--------------------------------------------------------------------------------  
  def edit
    set_current_script_uid("New")
  end

  #--------------------------------------------------------------------------------
  def update_status
    contract.update(galp_status: params[:status])
    render nothing: true
  end

  #--------------------------------------------------------------------------------
  def destroy
    contract.destroy
    redirect_to action: :index
  end

  private

  #--------------------------------------------------------------------------------
  def csv_contracts(contracts)
    csv_string = CSV.generate() do |csv|
      csv_headers = YAML.load_file(CSV_CONF_PATH)
      csv << csv_headers['headers']
      
      contracts = contracts.with_state(:csv_ready).order(:id)

      contracts.each { |contract| csv << contract.to_csv() }
    end
    
    # fucking excel support
    csv_string.encode Encoding.find("Windows-1252")
  end

  private

  #--------------------------------------------------------------------------------  
  def save_completed
    contract_params = params[:contract]
    if contract_form.validate(contract_params)
      contract = contract_form.save(current_user, true)

      redirect_to summary_contract_url(contract)
    else
      set_current_script_uid("New")
      render action: :new
    end
  end

  #--------------------------------------------------------------------------------  
  def save_uncompleted
    # seems to be needed set variables, so let's do it
    contract_form.validate(params[:contract])
    contract = contract_form.save(current_user, false)

    redirect_to action: :uncompleted
  end

  #--------------------------------------------------------------------------------
  def builded_contract
    contract = Contract.new
    contract.build_gaz_contract
    contract.build_luz_contract
    contract
  end
end