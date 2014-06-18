class ContractSummary
  include ApplicationHelper

  def initialize(contract)
    @contract = contract
  end

  #--------------------------------------------------------------------------------
  def summary
    text = [intro, fecha, infos_reminder, explication, legal_agreement, conclusion]    
    text.join.html_safe
  end

  #--------------------------------------------------------------------------------
  def intro
    representative_absent = @contract.representante.blank?
    if representative_absent
      user_name = @contract.fullname()
    else
      user_name = @contract.representante()
    end
    
    render_md I18n.t('sum.intro', user_name: user_name)
  end

  #--------------------------------------------------------------------------------
  def fecha
    month = I18n.t("date.month_names")[Date.today.month]
    render_md I18n.t('sum.fecha', 
                      hour: Time.now.hour,
                      min: Time.now.min,
                      day: Time.now.day,
                      month: month,
                      year: Time.now.year)
  end

  #--------------------------------------------------------------------------------
  def infos_reminder
    representative_absent = @contract.representante.blank?
    if representative_absent
      customer_infos_reminder()
    else
      representative_infos_reminder()
    end
  end

  #--------------------------------------------------------------------------------
  def email_infos
    if @contract.email.presence
      I18n.t('sum.email', email: @contract.email)
    else
      ''
    end
  end

  #--------------------------------------------------------------------------------
  def customer_infos_reminder

    render_md I18n.t('sum.customer_infos_reminder', 
                      customer_fullname: @contract.fullname(),
                      dni_titular_final: @contract.dni_titular_final,
                      telefono_1: @contract.telefono_1,
                      email: email_infos(),
                      address: @contract.address(),
                      operation: operation())         
  end

  #--------------------------------------------------------------------------------
  def representative_infos_reminder   
    render_md I18n.t('sum.representante_infos_reminder', 
                      representante_fullname: @contract.representante,
                      dni_representante: @contract.dni_representante,
                      customer_fullname: @contract.fullname(),
                      dni_titular_final: @contract.dni_titular_final,
                      telefono_1: @contract.telefono_1,
                      email: email_infos(),
                      address: @contract.address(),
                      operation: operation()) 
  end

  #--------------------------------------------------------------------------------
  def operation; end

  #--------------------------------------------------------------------------------
  def legal_agreement; end

  #--------------------------------------------------------------------------------
  def explication
    representative_absent = @contract.representante.blank?
    if representative_absent
      explication_customer()
    else
      explication_representante()
    end
  end
  
  #--------------------------------------------------------------------------------
  def explication_customer
    render_md I18n.t('sum.explication', 
                      numero_de_cuenta: @contract.numero_de_cuenta)
  end

  #--------------------------------------------------------------------------------
  def explication_representante
    render_md I18n.t('sum.explication_representante', 
                      numero_de_cuenta: @contract.numero_de_cuenta)
  end

  #--------------------------------------------------------------------------------
  def conclusion
    render_md I18n.t('sum.conclusion', codigo: "super_secret_code")
  end

end