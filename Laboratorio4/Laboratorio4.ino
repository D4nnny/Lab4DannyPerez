#include <DHT.h>  // include the DHT library

#define DHTPIN 2  // define digital pin 2 as the pin for the sensor
#define DHTTYPE DHT11  // define the sensor type as DHT11

DHT dht(DHTPIN, DHTTYPE);  // create a DHT object to handle the sensor

void setup() {
  Serial.begin(9600);  // start serial communication with the monitor at 9600 baud
  dht.begin();  // start communication with the sensor
}

void loop() {
  float temperature = dht.readTemperature();  // read the temperature from the sensor

  Serial.println(temperature);  // print the temperature in Celsius

  delay(1000);  // wait for one second before measuring temperature and humidity again
}
