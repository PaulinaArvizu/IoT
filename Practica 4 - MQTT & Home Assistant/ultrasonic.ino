#include <NewPing.h>
#include <DHT.h>

#define TRIGGER_PIN 22
#define ECHO_PIN 23
#define MAX_DISTANCE 200

#define DHT_PIN 32
#define DHT_TYPE DHT11

NewPing sonar(TRIGGER_PIN, ECHO_PIN, MAX_DISTANCE);
DHT dht(DHT_PIN, DHT_TYPE);

void setup() {
  Serial.begin(9600);
  dht.begin();
}

void loop() {
  delay(1000)

  float dist_ultrasonic = sonar.ping_cm();
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  
  if(isnan(humidity) || isnan(temperature)) {
      Serial.println("Failed to read from DHT sensor");
  }
  
  float sensacionTermica = dht.computeHeatIndex(temperature, humidity, false);

  Serial.print(dist_ultrasonic);
  Serial.print(" cm");
  Serial.println();
  
  Serial.print("humidity: ");
  Serial.print(humidity);
  Serial.print("°C");
  Serial.println();
  
  Serial.print("temperature: ");
  Serial.print(temperature);
  Serial.print("°C");
  Serial.println();
  
  Serial.print("Heat index: ");
  Serial.print(sensacionTermica);
  Serial.print("°C");
  Serial.println();

}
