#AQUEST PROGRAMA LLEGEIX UN STRING MULTILINEA!!

require 'i2c/drivers/lcd'
display=I2C::Drivers::LCD::Display.new('/dev/i2c-1',0x27)
puts"Escriu una frase multilinea"

#llegeix fins que hi ha 2 intros i elimina el ultim intro
frase=gets("\n\n").chop 	

#converteix l'string en un array 			
array=frase.split("\n")

#printa en el display
for i in (0..array.length-1)
	display.text(array[i], i)
end
