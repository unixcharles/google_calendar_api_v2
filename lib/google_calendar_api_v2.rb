module GoogleCalendarApiV2
  autoload :Client,   'google_calendar_api_v2/client'
  autoload :Base,     'google_calendar_api_v2/base'
  autoload :Calendar, 'google_calendar_api_v2/calendar'
  autoload :Event,    'google_calendar_api_v2/event'

  autoload :AuthenticationError, 'google_calendar_api_v2/error/authentication'

  module Response
    autoload :Base,     'google_calendar_api_v2/response/base'
    autoload :Calendar, 'google_calendar_api_v2/response/calendar'
    autoload :Event,    'google_calendar_api_v2/response/event'
  end
end