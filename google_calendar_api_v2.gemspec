Gem::Specification.new do |s|
  s.name        = 'google_calendar_api_v2'
  s.version     = '0.1.3'
  s.summary     = "Work with Google Calendar using GData 2.0 + OAuth 1.0"
  s.author      = ['Charles Barbier']
  s.email       = 'unixcharles@gmail.com'
  s.homepage    = 'http://www.github.com/unixcharles/google_calendar_api_v2'

  s.files        = Dir['README.md', 'LICENSE',
                       'lib/google_calendar_api_v2.rb',
                       'lib/google_calendar_api_v2/base.rb',
                       'lib/google_calendar_api_v2/client.rb',
                       'lib/google_calendar_api_v2/calendar.rb',
                       'lib/google_calendar_api_v2/event.rb',
                       'lib/google_calendar_api_v2/error/authentication.rb',
                       'lib/google_calendar_api_v2/response/base.rb',
                       'lib/google_calendar_api_v2/response/calendar.rb',
                       'lib/google_calendar_api_v2/response/event.rb']

  s.require_path = 'lib'

  s.add_runtime_dependency 'oauth'
end