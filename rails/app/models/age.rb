class Age

  attr_accessor :birthdate
  
  def initialize birthdate = nil
    self.birthdate = birthdate
  end

  def within? min_age, max_age
    (max_age.years.ago.to_date..min_age.years.ago.to_date).member? birthdate
  end

end
