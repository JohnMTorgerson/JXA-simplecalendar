JsOsaDAS1.001.00bplist00�Vscript_G

// load library
var cal = Library('simplecalendar')

// choose which calendar to work on
var homeCal = cal.setCalendar("Home")

// the setCalendar returns the actual calendar object in case you want to manipulate it directly
// e.g. homeCal.events.whose({summary: "example 1"})[0].show()

// find an event using the following named parameters (all are optional)
// currently, start and end times need to be a Unix timestamp (in seconds, not ms)
// but will change in the future to be more flexible
var event = cal.findEvent({start: 1576018800, end: 1576105200, title: "example 1"})                              ] jscr  ��ޭ