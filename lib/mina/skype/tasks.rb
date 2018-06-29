require 'skype_bot'

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

      announcement = "#{announced_deployer} successfully deployed #{announced_application_name} in #{humanize(elapsed)}."

      post_skype_message(announcement)
    else
      print_error_message
    end
  end

  def ready_to_run
    fetch(:skype_app_id) and fetch(:skype_app_secret) and fetch(:skype_conversation_id)
  end

  def print_error_message
    print_local_status "Unable to create Skype Announcement, no Skype details provided."
  end

  def announced_stage
    ENV['to'] || fetch(:rails_env) || 'production'
  end

  def announced_deployer
    fetch(:deployer)
  end

  def short_revision
    fetch(:deployed_revision)[0..7] if fetch(:deployed_revision)
  end

  def announced_application_name
    "".tap do |output|
      output << fetch(:skype_application) if fetch(:skype_application)
      output << " #{fetch(:branch)}" if fetch(:branch)
      output << " (#{short_revision})" if short_revision
    end
  end
  
  def config_skype
    SkypeBot::Config.app_id = fetch(:skype_app_id)
    SkypeBot::Config.app_secret = fetch(:skype_app_secret)
    
    @event = {'service_url' => 'https://smba.trafficmanager.net/apis', 
             'conversation_id' => fetch(:skype_conversation_id)}
    @skype_is_configured = true
  end

  def post_skype_message(message)
    config_skype unless @skype_is_configured

    # Bold in skype
    SkypeBot.message @event, "**#{message}**"
  end

  def humanize secs
    [[60, :seconds], [60, :minutes], [24, :hours], [1000, :days]].inject([]){ |s, (count, name)|
      if secs > 0
        secs, n = secs.divmod(count)
        s.unshift "#{n.to_i} #{name}"
      end
      s
    }.join(' ')
  end
end