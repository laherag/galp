class RecordUploader < CarrierWave::Uploader::Base
  storage :ftps

  def store_dir
    fecha_venta = model.contract.fecha_venta.strftime "%d%m%Y"
    folder = "GRABACIONES_#{fecha_venta}"
    
    type =
      if model.contract.moving_type.alta?
        "AD"
      elsif model.contract.moving_type.cambio?
        "CC"
      else
        "AC"
      end
    subfolder = "#{type}_#{fecha_venta}" 
    
    "records/#{folder}/#{subfolder}"
  end

  def filename
    model.contract.cig + ".wav"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
end
