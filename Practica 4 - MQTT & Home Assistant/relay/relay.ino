#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include "DHT.h"

#define RELAY 15  // Pin donde esta el relay

//No sirve profe, no sabemos por que :'/

const int TRIGGER_PIN = 12;
const int ECHO_PIN = 14;
#define MAX_DISTANCE 200


#define DHTTYPE DHT11
#define DHTPIN 5


// WIFI --- Set these to your desired credentials
const char *ssid = "Tenda_53CAF0";
const char *password = "piramide2";

// MQTT Broker
const char *mqtt_broker = "192.168.0.177";
const char *topic_hum = "iteso/sensor/hum";
const char *topic_temp = "iteso/sensor/temp";
const char *topic_term = "iteso/sensor/term";
const char *topic_ultra = "iteso/sensor/ultra";
const char *mqtt_username = "homeassistant";
const char *mqtt_password = "ahphailiChaefoh1aengeizohxe3ies4ohlahahsie7vo3AideehaeNaiv8aek2s";
const int mqtt_port = 1883;

WiFiClient espClient;
PubSubClient client(espClient);

DHT dht(DHTPIN, DHTTYPE, 27);
double temperatura, humedad;
long duration;
float distance;


void setup() {
    Serial.begin(115200);
    dht.begin();

  WiFi.begin(ssid, password);

  while(WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.println("connecting to wifi...");
  }

  Serial.println("connected to wifi network");
  //connecting to mqtt broker
  client.setServer(mqtt_broker, mqtt_port);
  client.setCallback(callback);
  while(!client.connected()){
    String client_id = "esp8266-client-";
    client_id += String(WiFi.macAddress());
    Serial.printf("the client %s connects to mqtt broker \n", client_id.c_str());
    if(client.connect(client_id.c_str(), mqtt_username, mqtt_password)) {
      Serial.println("public emqx broker connected");
    } else {
      Serial.print("fail with state ");
      Serial.println(client.state());
      delay(1000);
    }
  }
  //publish & subscribe
  client.publish(topic_hum, "1");
  client.publish(topic_temp, "1");
  client.publish(topic_term, "1");
  client.publish(topic_ultra, "1");
  
  client.subscribe(topic_hum);
  client.subscribe(topic_temp);
  client.subscribe(topic_term);
  client.subscribe(topic_ultra);

}

void callback(char *topic, byte *payload, unsigned int length) {
  Serial.print("message arrived in topic ");
  Serial.println(topic);

  Serial.print("message: ");
  for(int i = 0; i < length; i++) {
    Serial.print((char) payload[i]);
  }
  Serial.println();
  Serial.println("------------------------");
}

void loop() {
  client.loop();
  
  // ---- SENSORES ----
  //float dist_ultrasonic = sonar.ping_cm();

  digitalWrite(TRIGGER_PIN, LOW);   // Makes trigPin low
  delayMicroseconds(2);       // 2 micro second delay 
  
  digitalWrite(TRIGGER_PIN, HIGH);  // tigPin high
  delayMicroseconds(10);      // trigPin high for 10 micro seconds
  digitalWrite(TRIGGER_PIN, LOW);   // trigPin low
  
  duration = pulseIn(ECHO_PIN, HIGH);   //Read echo pin, time in microseconds
  distance = duration*0.034/2;        //Calculating actual/real distance
  
  float humidity = dht.readHumidity();
  float temperature = dht.readTemperature();
  
  if(isnan(humidity) || isnan(temperature)) {
      Serial.println("Failed to read from DHT sensor");
  }
  
    //float sensacionTermica = dht.computeHeatIndex(temperature, humidity, false);
  
    Serial.print(distance);
    Serial.println(" cm");
    
    Serial.print("humidity: ");
    Serial.print(humidity);
    Serial.println("°C");
    
    Serial.print("temperature: ");
    Serial.print(temperature);
    Serial.println("°C");
    
    Serial.print("Heat index: ");
    //Serial.print(sensacionTermica);
    Serial.println("°C");
    Serial.println();

    // send to mqtt

  char buff[16];
  
    itoa(humidity, buff, 10);
    client.publish(topic_hum, buff);
    itoa(temperature, buff, 10);
    client.publish(topic_temp, buff);
//    itoa(sensacionTermica, buff, 10);
//    client.publish(topic_term, buff);
    itoa(distance, buff, 10);
    client.publish(topic_ultra, buff);
  
  
    delay(1000);

  // ----------------
  












  
  
//  WiFiClient client = server.available(); // listen for incoming clients
//
//  if(client) {                        //if you get a client
//    Serial.println("New Client");     //print message out the serial port
//    String currentLine = "";          // make string to hold incoing data from client
//    while(client.connected()) {
//      if(client.available()) {
//        char c = client.read();
//        Serial.write(c);
//        if(c == '\n') {
//          // if current line is blank, you got 2 newline characters in a row
//          // that's the end of the client HTTP request, so send a response
//          if(currentLine.length() == 0) {
//            // HTTP headers always start with a responde code and a content-type so the client knows what's coming, then a blank line:
//            client.println("HTTP/1.1 200 OK");
//            client.println("Content-type:text/html");
//            client.println();
//
//            // the content of the HTTP response follows the header:
//            client.print("Click <a href=\"/L\">here</a> to turn ON the RELAY.<br>");
//            client.print("Click <a href=\"/H\">here</a> to turn OFF the RELAY.<br>");
//
//            // the HTTP response ends with another blank line:
//            client.println();
//
//            break;
//          } else { // if you got a newline, clear currentLine
//            currentLine = "";
//          }
//        } else if (c != '\r') { // if you got anything else but a carriage return character, ass it to the end of the currentLine
//          currentLine += c;
//        }
//
//        
//        // check to see if the client request was "GET /H" or "GET /L":
//        if(currentLine.endsWith("GET /H")) {
//          digitalWrite(RELAY, HIGH);      // GET /H turns RELAY off
//        }
//
//        if(currentLine.endsWith("GET /L")) {
//          digitalWrite(RELAY, LOW);      // GET /H turns RELAY on
//        }
//        
//      }
//    }
//    //close the connection
//    client.stop();
//    Serial.println("Client disconnected");
//  }

}
