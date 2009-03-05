module Demographic

  def within? other
    raise IncompatibleDemographic unless self.class === other

    return true if self == other

    within_check other
  end

  class IncompatibleDemographic < Exception; end

end
