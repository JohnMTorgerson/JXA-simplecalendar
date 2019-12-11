JsOsaDAS1.001.00bplist00�Vscript_�var app = Application.currentApplication()
app.includeStandardAdditions = true

var CalendarApp = Application("Calendar")
var calendar // will be the calendar object

// ------------ METHODS ------------ //
function setCalendar(calName) {
	try {
		var calendars = CalendarApp.calendars.whose({name: calName})
		calendar = calendars[0]
	}
	catch(error) {
		console.log('Couldn\'t set calendar (calendar may not exist?): ' + error)
	}
	// return the calendar object so the user can perform her own machinations on it if desired
	return calendar
}

// find event by any parameters passed, expecting an object of named parameters
// user passes start time as 'start', end time as 'end', and/or event summary as 'title'
// currently, start and end times should be in Unix epoch time (in seconds)
// (but in the future we should build in flexibility for the time formats)
// e.g. { start: 1576018800, end: 1576054062, title: "111th Birthday Party"}
function findEvent(params) {
	var calendarParams = {}
	var events
	
	try {
		if (params.hasOwnProperty('title')) calendarParams['summary'] = params['title']
		if (params.hasOwnProperty('start')) calendarParams['startDate'] = {_greaterThanEquals: new Date(1000 * params['start'])}
		if (params.hasOwnProperty('end')) calendarParams['endDate'] = {_lessThanEquals: new Date(1000 * params['end'])}
		
		events = calendar.events.whose(calendarParams)
	}
	catch(error) {
		console.log('Error finding event: ' + error)
	}	

	try {
		// return the first event found (if no event was found, this will throw an error)
		return events[0]()
	}
	catch(error) {
		// if no event was found, return null
		console.log('No matching event found')
		return null
	}	
}
                              �jscr  ��ޭ