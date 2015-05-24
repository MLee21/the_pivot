class Guest

  def administrator?
    false
  end

  def business_administrator?
    false
  end

  def registered_user?
    false
  end

  def platform_administrator?
    false
  end

  def name_to_display
    "Guest"
  end

end