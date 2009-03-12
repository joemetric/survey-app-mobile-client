module Income
  
  def within? min_income, max_income
    (min_income..max_income).member? self.to_i
  end

end
