class DniValidator < ActiveModel::EachValidator
  DNI_VERIFICATION_CODE = %w[T R W A G M Y F P D X B N J Z S Q V H L C K E]

  #--------------------------------------------------------------------------------    
  def validate_each(record, attribute, dni = true)    
    if dni == nil || dni[0] =~ /[a-zA-Z]/
      return
    end

    errors = record.errors[attribute]

    if dni.size != 9
      errors  << "dni esta inválido : el tamaño debe ser de 9 caracteres"
      return
    end

    code = dni[0..7].to_i

    mod = code % 23
    verification_letter = DNI_VERIFICATION_CODE[mod]

    cups_valid = (verification_letter == dni[-1])

    errors << "cups esta inválido" unless cups_valid
  end
end