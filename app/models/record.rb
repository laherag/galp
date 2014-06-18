class Record < ActiveRecord::Base
  mount_uploader :file, RecordUploader

  belongs_to :contract
end
