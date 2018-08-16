class Meetup < ApplicationRecord
  include HTTParty
  base_uri 'api.meetup.com'

  def get_data #trouve tous les données des groupes dans la catégorie tech en France
    self.class.get('/find/groups?country=France&category=34')
  end

  def groupstech
    get_data.parsed_response
  end
end
