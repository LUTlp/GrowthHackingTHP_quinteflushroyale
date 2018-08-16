class MeetupController < ApplicationController
  # Appelle la gem dotenv
  require 'dotenv-rails'
  # Ceci appelle le fichier .env grâce à la gem dotenv, et enregistre toutes les données enregistrées dans une hash ENV


  def index
    Dotenv.load
    puts ENV['MEETUP_API_KEY']
    @groups = Meetup.new.groupstech
    puts @groups
    render json: @groups
  end
end
