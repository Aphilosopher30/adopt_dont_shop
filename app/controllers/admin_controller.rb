class AdminController < ApplicationController

  def shelters
#    @shelters = Shelter.all.order(name: :desc)
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")

  end

end
