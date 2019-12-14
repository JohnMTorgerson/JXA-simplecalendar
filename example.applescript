// load library
var cal = Library('simplecalendar')

// choose which calendar to work on
// the setCalendar method returns the actual calendar object in case you want to manipulate it directly
// e.g. homeCal.events.whose({summary: "example 1"})[0].show()
var homeCal = cal.setCalendar("Home")

// create a new event using the following named parameters (all are optional)
// currently, start and end times need to be a Unix timestamp (in seconds, not ms)
// but will expand in the future to be more flexible
// method returns the event
var event = cal.createEvent({start: 1576018800, end: 1576105200, title: "example 1"})

// find an event using the following named parameters (all are optional)
// currently, start and end times need to be a Unix timestamp (in seconds, not ms)
// but will expand in the future to be more flexible
// method currently returns only the first event found
var event = cal.findEvent({start: 1576018800, end: 1576105200, title: "example 1"})

// test for whether an event was successfully found by checking for null value
if (event !== null) {
	// delete event by passing event object into delete method
	// this appears to take a while to register with the calendar
	cal.deleteEvent(event)
}