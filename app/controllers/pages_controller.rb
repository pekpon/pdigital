class PagesController < ApplicationController
  def ads
    respond_to do |format|
       format.html # ads.html.erb
     end
  end
end
