# Find & Create + Update & Delete

All you need to survive a syncronization project with Google Calendar using GData 2.0 + OAuth 1.0

# Synopsis

    require 'google_calendar'
    client = GoogleCalendarApiV2::Client.new "teambox.com", "secret", "oauth_token", "oauth_secret"

    calendar = client.calendars.find 'calendar_token' || client.calendars.create { :title => "Teambox" }

    calendar[:title] = 'Teambox calendar'

    calendar.save

    event = calendar.events.find 'calendar_token'

    event[:title] = 'Updated event name'
    event.save

    event.destroy
    calendar.destroy