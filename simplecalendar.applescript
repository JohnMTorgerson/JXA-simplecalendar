var app = Application.currentApplication()
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
		throw 'Couldn\'t set calendar (calendar may not exist?): ' + error.toString()
	}
	// return the calendar object so the user can perform her own machinations on it if desired
	return calendar
}

// create event by any parameters passed, expecting an object of named parameters
// user passes start time as 'start', end time as 'end', and/or event summary as 'title'
// currently, start and end times should be in Unix epoch time (in seconds)
// (but in the future we should build in flexibility for the time formats)
// e.g. { start: 1576018800, end: 1576054062, title: "111th Birthday Party"}
// all parameters are optional, but I don't know what happens if you try to create an event with no content
function createEvent(params) {
	var calendarParams = {}
	var event
	
	// create event with given parameters
	try {
		if (params.hasOwnProperty('title')) calendarParams['summary'] = params['title']
		if (params.hasOwnProperty('start')) calendarParams['startDate'] = new Date(1000 * params['start'])
		if (params.hasOwnProperty('end')) calendarParams['endDate'] = new Date(1000 * params['end'])
		
		event = CalendarApp.Event(calendarParams)
	}
	catch(error) {
		throw 'Error creating event: ' + error.toString()
	}	

	// add event to calendar
	try {
		calendar.events.push(event)
	}
	catch(error) {
		throw 'Error adding event to calendar: ' + error.toString()
	}
	
	return event
}

// find event by any parameters passed, expecting an object of named parameters
// user passes start time as 'start', end time as 'end', and/or event summary as 'title'
// currently, start and end times should be in Unix epoch time (in seconds)
// (but in the future we should build in flexibility for the time formats)
// e.g. { start: 1576018800, end: 1576054062, title: "111th Birthday Party"}
// all parameters are optional
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
		throw 'Error finding event: ' + error.toString()
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

// Delete an event, passing the event object
// I couldn't find any documentation about this at all, so this has been trial and error
function deleteEvent(event) {
//CalendarApp.delete(event) // doesn't work
	for (var i = 0; i < calendar.events.length; i++) {
		if (calendar.events[i].uid() == event.uid()) {
			try {
				//calendar.events.splice(i, 1) // doesn't work
				CalendarApp.delete(calendar.events[i]) // appears to work, though it takes a while for the event to disappear?
				//calendar.events[i].delete() // also appears to work, I think the same as the above line			
				CalendarApp.reloadCalendars() // unsure if this is necessary or even helps
				return true
			}
			catch(error) {
				throw 'Event found, but error deleting event: ' + error.toString()
				return false
			}
		}
	}
	// if we're here, we were unable to find a matching event
	console.log('unable to find matching event to delete')
	return false
}
