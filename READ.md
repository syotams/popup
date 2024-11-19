# Animated Popup Plugin for Godot 4.0 
## What is it?
The plugin adds a new type AnimatedPopup, which adds the abilitiy to animate popups  
Currently the only animation supported is "Over Inflated Popups" both on display (enter) and on dismiss (exit)  
When showed, it is over inflating, then it shrinks back to its desired size, on dismiss it over scaled again then shrinks to 0 and disapears

## Usage
Add AnimatedPopup as a child node to the scene make it hidden  
Show the popup
  
await $AnimatedPopup.popup()  
  
Hide it:

await $AnimatedPopup.dismiss()  


In Inspector panel, you can set the background color and "Click to Dismiss" option,  
which will hide the popup on any click on the screen out of the popoup boundaries
