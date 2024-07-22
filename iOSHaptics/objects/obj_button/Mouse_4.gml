y = Y_location + 10;

switch (button_name) {
case "Single":
show_message_async("iOS_triggerVibration(length)");
iOS_triggerVibration(0.25);
break;
case "Double":
show_message_async(" iOS_triggerDoubleVibration(first_length,pause,second_length)");
iOS_triggerDoubleVibration(0.25,0.1,0.25);
break;
case "Fanfare":
show_message_async("iOS_triggerFanfare();");
iOS_triggerFanfare();
break;
case "Pop":
show_message_async("iOS_triggerPop();")
iOS_triggerPop();
break;
case "Strong":
show_message_async("iOS_triggerStrong();");
iOS_triggerStrong();
break;
case "Two Pops":
show_message_async("iOS_triggerDoublePop()");
iOS_triggerDoublePop();
break;
case "Swell 1":
show_message_async("iOS_triggerSwell(length, initial_intensity, final_intensity); Intensity Range: 0.0 to 1.0");
iOS_triggerSwell(1,1,0);
break;
case "Swell 2":
show_message_async("iOS_triggerSwell(length, initial_intensity, final_intensity); Intensity Range: 0.0 to 1.0");
iOS_triggerSwell(1,0,1);
break;
case "Wave 1":
show_message_async("iOS_triggerWave(length, initial_intensity, final_intensity); Intensity Range: 0.0 to 1.0");
iOS_triggerWave(2,0,1)
break;
case "Wave 2":
show_message_async("iOS_triggerWave(length, initial_intensity, final_intensity); Intensity Range: 0.0 to 1.0");
iOS_triggerWave(2,1,0)
break;

}