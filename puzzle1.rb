require 'i2c/drivers/lcd'
display=I2C::Drivers::LCD::Display.new('/dev/i2c-1', 0x27, rows=20, cols=4)
rows=20
cols=4
i=0
display.clear

while i<4
  puts "Escriu una paraula"
  paraua=gets
  llargada=paraula.length
  
  #quan ja he escrit les 4 files, es neteja el display
  if i==0 
    display.clear
  end
  
  if llargada<=rows                     #si la paraula te menys de rows caracters, s'escriu en una sola linea  
    display.text(paraula.chop, i)       #treu l'ultim caracter, que es el intro
    i=(i+1)%5
  
  elsif llargada>rows*(cols-i)          #si la paraula té més lletres que espais lliures, no s'escriu
    puts "paraula massa llarga"
    
  else                                  #si la paraula es pot escriure en varies linesas, s'escriu
    inici=0
    while llargada>20
      display.text(paraula[inici,inici+rows-1], i)
      llargada=llargada-rows
      inici=inici+rows-1
      i=(i+1)%5
    end
    display.text(paraula[inici, inici+llargada].chop, i)
    i=(i+1)%5
  end
end
