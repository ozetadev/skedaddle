# skedaddle

This app aims to hit all assigned points for the project.

  - Google Places: I use the Google Places API to auto-fill information in the routing text fields, as well as calculating     geometry
  - Connect to an API of some form (ex: weather API): I connect to the Uber pricing API, to show the user the alternative     (insane) Uber pricing. Note: This only works on trips that are under 100 miles, Uber refuses to give pricing on longer trips (A drag, I know). I went with UberX Pricing, but in the real world I'd probably show SUV.
  - Autocomplete: I autocomplete in the location field from the Google Places API, as well as   [add second source]
  - Some form of a ticket or pass, with an animation: QR code presented / ticket, animated with ripple effect by CATransition, not a great way to do ticketing but meets the challenge ;)


A few points:
  - I apologize for the lack of unit testing, and quality error handling. Normally this would obviously be done, but with the time     allotted I wanted to hit all the required points well.
  - I am a 5+ year Objective-C veteran. I am intimately familiar with Cocoa Touch and UIKit. This is legitimately my first     time using Swift for real. If I have one real talent, it is learning quickly.
  - I *REALLY* wanted to include a Passbook pass for your ticket, but the provisioning and signing is not viable given the     time period.
