ArduinoFirmata = require 'arduino-firmata'

module.exports = (linda) ->

  config = linda.config
  ts = linda.tuplespace config.linda.space

  arduino = new ArduinoFirmata().connect config.arduino.port

  arduino.once 'connect', ->
    linda.debug 'arduino connected (#{config.arduino.port})'
    setInterval ->
      light = arduino.analogRead 0
      linda.debug "light : #{light}"
      ts.write
        type:  "sensor"
        name:  "light"
        where: config.where
        value: light

      temp = arduino.analogRead(1)*5*100/1024
      linda.debug "temprature : #{temp}"
      ts.write
        type:  "sensor"
        name:  "temperature"
        where: config.where
        value: temp
    , 1000
