require 'credit_card_validations'
class Contact < ApplicationRecord
  include ActiveModel::Validations
  belongs_to :user
  validates_presence_of :name, :birthday, :telephone, 
                        :address, :franchise, 
                        :email, :user
  # Email Validations
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # Credit Card Validations
  validates :credit_card, presence: true, credit_card_number: true
  before_save :get_cc_brand
  # Birthday Validations
  validate :validate_birthday
  # Telephone Validations
  validate :validate_telephone
  # Name Validations
  validates_format_of :name, :with => /\A[a-zA-Z'-]+$\Z/i

  FilterSerializer = Rack::Reducer.new(
    self.all,
    ->(query_email:) { self.where(email: query_email) },
  )

  def get_cc_brand
    detector = CreditCardValidations::Detector.new(self.credit_card)
    self.franchise = detector.brand
    self.credit_card = "#{Digest::SHA256.hexdigest(self.credit_card)}-#{self.credit_card.last(4)}"
  end

  def validate_birthday
    errors.add(:birthday, 'Invalid date format') unless self.birthday.match?(/\d{4}\d{2}\d{2}/) or self.birthday.match?(/\A([0-9]{4})(-?)(1[0-2]|0[1-9])\2(3[01]|0[1-9]|[12][0-9])\Z/i)
  end

  def validate_telephone
    errors.add(:telephone, 'Invalid phone format') unless self.telephone.match?(/\(?\+[0-9]{2}\)? [0-9]{3} [0-9]{3} [0-9]{2} [0-9]{2}/) or self.telephone.match?(/\(?\+[0-9]{2}\)?-[0-9]{3}-[0-9]{3}-[0-9]{2}-[0-9]{2}/)
  end
  
end
