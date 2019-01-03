
# Installation des DS18B20
# https://webnist.de/temperatur-sensor-ds1820-am-raspberry-pi-mit-python/
#
# sudo modprobe wire 
# sudo modprobe w1-gpio 
# sudo modprobe w1-therm
#
# sudo nano /etc/modules
# und fügst folgende drei Zeilen ein.
# wire
# w1-gpio
# w1-therm
# Ab Kernel 3.8 ist die Datei config.txt für das Laden der Module zuständig. Diese rufst du mit dem Befehl
#
# sudo nano /boot/config.txt
# auf und hängst folgende zwei Zeilen an, der Kommentar ist optional.
# # temperatur sensor
# dtoverlay=w1-gpio,gpiopin=26
#
# sudo reboot
# sudo lsmod
#
# cd /sys/bus/w1/devices
# in das Busverzeichnis wechselst und den Befehl zur Anzeigen des Inhaltsverzeichnisses ausführst.
# Bei einem Sensor werden dir nun zwei Verzeichnisse angezeigt. Ein Verzeichnis ist “w1_bus_master1”, das für uns wichtige Verzeichnis ist das mit einer Code-Bezeichnung, in meinem Fall “28-000005d2e508”.
#
# cat /sys/bus/w1/devices/28-000005d2e508/w1_slave


# Read out Sensor
a = `cat /sys/bus/w1/devices/28-03168b2b31ff/w1_slave`

# Read Time
time = Time.now.strftime("%d.%m.%Y-%H:%M")

# Allocate raw temparature string
c = ""

# Iterate over Raw Sensor Data String Lines
a.each_line do |line|
  # Match temperature
  if b=line.match(/(?:.*t=)(?<temp>-?\d+)/)
    # Store temparature
    c = b["temp"]
  end
end 

# Generate temperature string
if c[0]=="-"
    # if sub zero
    temperature = "-" + c[1] + "." + c[2..3]
else
  if c.size>4
    # if over 10
    temperature = c[0..1] + "." + c[2..3]
  else
    # if over 0 but under 10
    temperature = c[0]    + "." + c[1..2]
  end
end

# Write data file
#
#
#
#

open('/home/pi/data', 'a') { |f|
   f.puts time.to_s + " " + temperature
}


#File.write('/home/pi/data', time.to_s + " " + temperature)

# Print to standart out for writing into file in cronjob
puts time.to_s + "	" + temperature + " <br>"

