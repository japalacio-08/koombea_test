class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :birthday, :telephone, :formated_birthday,
              :address, :franchise, :email, :credit_card

  def formated_birthday
    self.object.birthday.to_date.strftime("%Y %B %d")
  end

  def birthday
    self.object.birthday.to_date
  end

  def credit_card
    cc = self.object.credit_card.split('-')
    return {
      token: cc[0],
      last_four: cc[1] 
    }
  end
  
  
  
end
