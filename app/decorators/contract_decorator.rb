class ContractDecorator < Draper::Decorator
  delegate_all

  #--------------------------------------------------------------------------------
  def titular
    if ! object.representante.blank?
      object.representante
    else
      object.titular_final
    end
  end

  #--------------------------------------------------------------------------------
  def fullname
    "#{object.nombre} #{object.apellido}"
  end

  #--------------------------------------------------------------------------------
  def representante_fullname
    "#{object.apellido} #{object.nombre}"
  end

  #--------------------------------------------------------------------------------
  def address
    "#{object.direccion} #{object.municipio} 
     #{object.zip_code} #{object.provincia}"
  end
end
