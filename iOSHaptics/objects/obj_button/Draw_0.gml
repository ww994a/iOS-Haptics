/// @description Draw button and text

draw_sprite(spr_button,0,x,y);

draw_set_font(fnt_main);
var text_width = string_width(button_name)
draw_text(x-text_width/2,y+10,button_name);
