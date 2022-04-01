require_relative "lcd.rb"
require "gtk3"
require 'i2c/drivers/lcd'
display=I2C::Drivers::LCD::Display.new('/dev/i2c-1',0x27)
	
window = Gtk::Window.new("Puzzle 2")
window.set_size_request(305, 120)
window.set_border_width(10)

grid=Gtk::Grid.new
window.add(grid)

buf=Gtk::TextView.new
buf.set_size_request(205,80)
buf.set_monospace(true)
buf.set_wrap_mode(1)

button = Gtk::Button.new(:label => "Escriure")
button.signal_connect "clicked" do |_widget|
  array=buf.buffer.text.split("\n")
  
  #printa en el display
  display.clear
  for i in (0..array.length-1)
	display.text(array[i], i)
  end
end

grid.attach(buf,3,0,3,1)
grid.attach(button, 0, 1, 9, 1)

window.add (grid)
window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
window.show_all

Gtk.main
