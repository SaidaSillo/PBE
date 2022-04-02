require "gtk3"
require 'i2c/drivers/lcd'

class GtkLcd
	def init_window
		@@window = Gtk::Window.new("Puzzle 2")
		@@window.set_size_request(205, 120)
		@@window.set_border_width(10)

		@@grid=Gtk::Grid.new		#incloem la quadricula
		@@window.add(@@grid)
	end
	
	def finish_window
		@@window.signal_connect("delete-event") { |_widget| Gtk.main_quit }
		@@window.show_all
		Gtk.main
	end

	def init_button
		#Creem el botó
		button = Gtk::Button.new(:label => "Escriure")
		
		#Printem a la LCD
		display=I2C::Drivers::LCD::Display.new('/dev/i2c-1',0x27)
		button.signal_connect "clicked" do |_widget|
			array=@@buf.buffer.text.split("\n")
			display.clear
			for i in (0..array.length-1)
				display.text(array[i], i)
			end
		end
		@@grid.attach(button, 0, 1, 9, 1)
	end

	def init_textView
		#Creem el recuadre de text
		@@buf=Gtk::TextView.new
		@@buf.set_size_request(205,80)
		@@buf.set_monospace(true)	#monoespai per la font
		@@buf.set_wrap_mode(1)		#limita els caràcters que es veuen en una fila
		@@grid.attach(@@buf,3,0,3,1)
	end
end

if __FILE__==$0
	gtk=GtkLcd.new
	
	gtk.init_window
	gtk.init_button
	gtk.init_textView
	gtk.finish_window
end
