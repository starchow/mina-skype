# Required
set :skype_app_id,          -> { ENV['SKYPE_APP_ID'] } unless set?(:skype_app_id)
set :skype_app_secret,      -> { ENV['SKYPE_APP_SECRET'] } unless set?(:skype_app_secret)
set :skype_conversation_id, -> { ENV['SKYPE_CONVERSATION_ID'] } unless set?(:skype_conversation_id)

# Optional
set :skype_application,     -> { ENV['SKYPE_APPLICATION'] || fetch(:application) } unless set?(:skype_application)

# Git
set :deployer,              -> { ENV['GIT_AUTHOR_NAME'] || %x[git config user.name].chomp } unless set?(:deployer)
set :deployed_revision,     -> { ENV['GIT_COMMIT'] || %x[git rev-parse #{fetch(:branch)} unless set?()].strip } unless set?(:deployed_revision)
