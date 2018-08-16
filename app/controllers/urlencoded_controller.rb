class UrlencodedController < ApplicationController
  def tokenaccess
    render "https://secure.meetup.com/oauth2/accessclient_id=p5d6i70g2dkse969h33ht23jpq&client_secret=35eq2sc3bbf4j3gdhfl546r00d&grant_type=authorization_code&redirect_uri=https://www.thehackingproject.org/&code=e4e6f38c7b86a565dffe85554705323a"
  end
end
