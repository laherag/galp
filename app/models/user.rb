class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         #:registerable,
         #:recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :stats, class_name: 'UserStats'

  scope :teleop, -> { where(teleop: true) }

  def can_edit_contract?
    admin || teleop
  end

  def can_change_contract_status?
    admin || galp
  end

  def view
    if admin
      AdminDecorator.new(self)
    elsif teleop
      TeleopDecorator.new(self)
    else
      GalpDecorator.new(self)
    end
  end
end
