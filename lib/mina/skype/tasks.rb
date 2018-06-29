require 'mina/hooks'
require 'skype_bot'

# Before and after hooks for mina deploy
before_mina :deploy, :'skype:starting'
after_mina :deploy, :'skype:finished'


# Skype tasks
namespace :skype do

  task :starting do
    if ready_to_run
      announcement = "#{announced_deployer} is deploying #{announced_application_name} to #{announced_stage}"

      post_skype_message(announcement)
      set(:start_time, Time.now)
    else
      print_error_message
    end
  end

  task :finished do
    if ready_to_run
      end_time = Time.now
      start_time = fetch(:start_time)
      elapsed = end_time.to_i - start_time.to_i

      announcement = "#{announced_deployer} successfully deployed #{announced_application_name} in #{elapsed} seconds."

      post_skype_message(announcement)
    else
      print_error_message
    end
  end

  def ready_to_run
    skype_app_id and skype_app_secret and skype_conversation_id
  end

  def print_error_message
    print_local_status "Unable to create Skype Announcement, no Skype details provided."
  end

  def announced_stage
    ENV['to'] || rails_env || 'production'
  end

  def announced_deployer
    deployer
  end

  def short_revision
    deployed_revision[0..7] if deployed_revision
  end

  def announced_application_name
    "".tap do |output|
      output << skype_application if skype_application
      output << " #{branch}" if branch
      output << " (#{short_revision})" if short_revision
    end
  end
  
  def config_skype
    SkypeBot::Config.app_id = skype_app_id
    SkypeBot::Config.app_secret = skype_app_secret
    
    @event = {'service_url' => 'https://smba.trafficmanager.net/apis', 
             'conversation_id' => skype_conversation_id}
    @skype_is_configured = true
  end

  def post_skype_message(message)
    config_skype unless @skype_is_configured

    SkypeBot.message @event, message
  end
end