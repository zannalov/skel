#!/usr/bin/env osascript

if application "Google Chrome" is running then
	tell application "Google Chrome" to set windowCount to number of windows
	repeat with windowNumber from 1 to windowCount
		tell application "Google Chrome" to set tabCount to number of tabs of window windowNumber
		repeat with tabNumber from 1 to tabCount
			tell application "Google Chrome" to set myUrl to URL of tab tabNumber of window windowNumber
			if myUrl starts with "https://meet.google.com/" then
				return "Meet"
			end if
			if myUrl starts with "https://TEAM_NAME.slack.com/call/" then
				return "Slack"
			end if
			if myUrl starts with "https://app.gotowebinar.com/" then
				return "GoToWebinar"
			end if
			if myUrl starts with "https://zoom.us/wc/" then
				return "Zoom"
			end if
			if myUrl starts with "https://SUBDOMAIN.kontiki.com/" then
				return "Kontiki"
			end if
		end repeat
	end repeat
end if

if application "GoToMeeting" is running then
	return "GoToMeeting"
end if

if application "zoom.us" is running then
	tell application "System Events"
		tell process "zoom.us"
			set windowCount to number of windows
			repeat with windowNumber from 1 to windowCount
				set windowName to name of window windowNumber
				if windowName begins with "Zoom Meeting ID:" then
					return "Zoom"
				end if
			end repeat
		end tell
	end tell
end if

return "None"
