class WelcomeController < ApplicationController

  def index
  end

  def wall
      current_user.facebook.feed!( :message => 'The Matrix has me.', 
      :name => 'My Rails 3 App with Omniauth, Devise and FB_graph' )
      redirect_to 'thematrixfcbk'
  end

end
