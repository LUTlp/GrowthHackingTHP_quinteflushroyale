# $ EDITOR="subl --wait " bin/rails credentials:edit pour la création du fichier master key 
# et enregistrement des code API twitter :
# twitter_api_key: cblablaSHcv
###########################################################################################
# dans app/services/TweetServ.rb
require 'twitter'
require 'json'
# require 'dotenv'
# Dotenv.load


class TweetServ
	

	def initialize
		
		@client = Twitter::REST::Client.new do |config|
		  	config.consumer_key        = Rails.application.credentials.dig(:twitter_api_key)
		  	config.consumer_secret     = Rails.application.credentials.dig(:twitter_api_secret)
		  	config.access_token        = Rails.application.credentials.dig(:twitter_token)
		  	config.access_token_secret = Rails.application.credentials.dig(:twitter_token_secret)
		end
		perform
 	end

	def putain_de_tw
 		@client.update('test4')
 	end
# recherche globale (pas comme post_mess) pour selectionner des user à follow très largement pour plus de visibilité
def user_search	
	@myarray = []
	@myarray_cloud_word = ["nouvelles technologies", "ruby", "rails", " hautes technologies", "internet" ,"innovation" ,"Nanotechnologie", "Révolution numérique", "TIC",
	"cybersecurity", "privacy", "cryptocurrency", "blockchain" ,"crypto", "safety", "digitalsecurity" ,"infosec", "fintech", "hightech" ,"startup", "iot" ,"hackers" ,"tips", "tech" ]   
	@a = @myarray_cloud_word.sample			
	@myarray = @client.user_search(@a)
	 	
end

# création d'une bdd json pour garder l'historique des personnes followées
def create_json_file
    File.open("db/data_id_tw.json", "w") do |f|
      f.write(@myarray.to_json)
    end
 end


# racolage-2: si un user a hastag le nuage de mot: envoi d'un message reprenant l'adresse du site THP 
	def post_mess
    @client.search('#{@a}').each do |tweet|
    @client.update("@#{tweet.user} Hey, it could interest you: https://growthhackingquinteroyale.herokuapp.com!  :)")
    end
    end



def perform
	putain_de_tw
	user_search	
	post_mess
	create_json_file
end

end


#############################################################################################
# dans lib/task/scheduler.rake (fichier à créer)

desc "This task is called by the Heroku scheduler add-on"
task :update_feed => :environment do
  puts "Procédure racolage lancée" #mon comm avant
  TweetServ.new.perform # fonction  pour follow twiter +json et tt!
  puts "fait"#mon comm après
end
############ paramétrer dans heroku la fréquence de la tâche
