class PagesController < ApplicationController
  def advertising
    respond_to do |format|
       format.html # advertising.html.erb
     end
  end
end
