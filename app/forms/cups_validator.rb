# a CUPS is a spanish code belonging to each spanish 
class CupsValidator < ActiveModel::EachValidator
  CUPS_LETRA = %w[T R W A G M Y F P D X B N J Z S Q V H L C K E]
  
  #--------------------------------------------------------------------------------    
  def validate_each(record, attribute, cups = true)    
    if cups == nil
      return
    end

    errors = record.errors[attribute]
    
    if cups.size != 20 and cups.size != 22
      errors  << "cups esta inválido : el tamaño debe ser de 20 o 22 caracteres"
      return
    end

    code = cups.slice(2,18).to_i
    verification_letter_1 = cups[18]
    verification_letter_2 = cups[19]

    resto0 = code % 529
    
    cociente1 = (resto0 / 23)
    resto1 = resto0 % 23

    letter_1 = CUPS_LETRA[cociente1]
    letter_2 = CUPS_LETRA[resto1]

    cups_valid = (letter_1 == verification_letter_1 && letter_2 == verification_letter_2)
    
    if ! cups_valid
      errors << "cups esta inválido"
    end
  end
end