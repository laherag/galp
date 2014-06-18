CarrierWave.configure do |config| 
  config.ftps_host =   ENV["FTP_HOST"]
  config.ftps_user =   ENV["FTP_USER"]
  config.ftps_passwd = ENV["FTP_PASSWD"]
  config.ftps_folder = ENV["DIR"]
  config.ftps_passive = true
  config.ftps_mode = :implicit
  config.ftps_context_params = { verify_mode: OpenSSL::SSL::VERIFY_NONE }
end