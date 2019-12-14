# SimpleCalendar

A JXA (Javascript for Automation) library for use with MacOS scripting
Provides (very) simple functionality for adding/deleting events in the Calendar app

## Rationale:

I find myself using Apple Scripting to automate Calendar interactions (and other things) on MacOS, since iCloud does not have a public web API. In service of modularizing my code to that end, I've created a few small libraries for my own use (see also my **simplelogger** project). I know there are various ways to hook up to well-developed Javascript libraries and use them for JXA, but I've decided to create a few of my own anyway, partly as a coding exercise, and partly because I only need to do a few simple things. Thus, figuring out how to import a bunch of NodeJS stuff for use in JXA simply seems like overkill for my use case. If you find yourself in a similar situation, perhaps these could be of some use.

## Usage:

* Place simplecalendar.scpt into ~/Library/Script Libraries, and call from within your script as documented by Apple (i.e. *var calendar = Library('simplecalendar')*)
* See *example.scpt* for usage
* Current functionality is limited to:
  * Creating a calendar event by providing calendar name, start date, end date, and event title
  * Finding/Deleting a calendar event by providing calendar name, start date, end date, and event title
* Future functionality may include the ability to add/search other event parameters allowed by Calendar
* .scpt files are compiled files, but can be viewed and edited in Script Editor. I've also included the same code as .js files for ease of viewing online
