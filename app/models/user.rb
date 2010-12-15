class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable
  #:registerable, :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :token

  def self.find_for_facebook_oauth(access_token, signed_in_resource=nil)
    # Get the user email info from Facebook for sign up
    # You'll have to figure this part out from the json you get back
    data = access_token['extra']['user_hash']
    if user = User.find_by_email(data["email"])
      user
    else
      # Create an user with a stub password.
      puts access_token['credentials']['token']
      User.create!( :token => access_token['credentials']['token'], :email => data["email"], :password => Devise.friendly_token) #, :token => access_token['credentials']['token'] )
      # , :access_token => data['credentials']['token'] ) # access_token)
      # puts data.inspect
      # :name => data["name"], 
    end
  end

  def facebook
    @fb_user ||= FbGraph::User.me( self.token ) # authentications.find_by_provider('facebook').token)
  end

end
