# Required
set_default :skype_app_id,          -> { ENV['SKYPE_APP_ID'] }
set_default :skype_app_secret,      -> { ENV['SKYPE_APP_SECRET'] }
set_default :skype_conversation_id, -> { ENV['SKYPE_CONVERSATION_ID'] }

# Optional
set_default :skype_application,     -> { ENV['SKYPE_APPLICATION'] || application }

# Git
set_default :deployer,              -> { ENV['GIT_AUTHOR_NAME'] || %x[git config user.name].chomp }
set_default :deployed_revision,     -> { ENV['GIT_COMMIT'] || %x[git rev-parse #{branch}].strip }
