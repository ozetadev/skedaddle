# Skedaddle Demo App

## Learned Swift (I'm an Objective-C guy) for this project. They went in another direction, but I like my first project, so I'm sharing it with you all.

This app aims to hit all assigned points for the project.

  - Google Places: I use the Google Places API to auto-fill information in the routing text fields, as well as calculating     geometry
  - 
  - Connect to an API of some form (ex: weather API): I connect to the Uber pricing API, to show the user the alternative     (insane) Uber pricing. Note: This only works on trips that are under 100 miles, Uber refuses to give pricing on longer trips (A drag, I know). I went with UberX Pricing, but in the real world I'd probably show SUV.
  
  - Autocomplete: I autocomplete in the location field from the Google Places API. When you are not connected to the internet, the autocomplete uses a database (in the form of JSON) of cities in the USA to guess what you're typing. Not as pretty, but does the job. That makes two sources.
  
  - Some form of a ticket or pass, with an animation: QR code presented / ticket, animated with ripple effect by CATransition, not a great way to do ticketing but meets the challenge ;)


A few points:
  - The app is particularly verbose while in debug setting. I am constantly adding more to this as I have time, so I left it as it is. Can easily be disabled. Mostly use the logs to watch as autocomplete does its job.
  - I apologize for the lack of unit testing, and quality error handling. Normally this would obviously be done, but with the time allotted I wanted to hit all the required points well.
  - I am a 5+ year Objective-C veteran. I am intimately familiar with Cocoa Touch and UIKit. This is legitimately my first     time using Swift for real. If I have one real talent, it is learning quickly.
  - I *REALLY* wanted to include a Passbook pass for your ticket, but the provisioning and signing is not viable given the     time period.
