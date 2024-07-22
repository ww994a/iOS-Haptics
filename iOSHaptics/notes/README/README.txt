A few items to get things working...

In GameMaker, iOS Options:
-Enter your Team Name from your Apple Developer account in order to load on a device.
It should be somthing like K3511FXSW2 (I made that one up) 
-Also update the bundle name.
-Build Setting should be set to minimum Version 13.0

Try the demo first, feel free to customize the vibrations. 
The script to trigger in located in obj_button - Left Pressed

There are three methods:

iOS_triggerVibration(length);
iOS_triggerDoubleVibration(first_length,pause,second_length);
iOS_triggerFanfare();

Single and Double Vibrations are customizable, allowing for a great variety of vibrations.
For example, iOS_triggerDoubleVibration(0.5,0.125,0.125), creates a double vibration with 
a long first vibration followed by a short pause and short vibration.

