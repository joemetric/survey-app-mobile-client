module Age

  def within? min_age, max_age
    (max_age.years.ago.to_date..min_age.years.ago.to_date).member? self
  end

end
