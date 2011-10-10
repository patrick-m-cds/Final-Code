#include <Servo.h>  
      
      Servo myservo;  // create servo object to control a servo  
      int potpin = 0;  // analog pin used to connect the photoresistor
      int val;    // variable to read the value from the analog pin  
      int pos = 0; // variable to store the servo position
      
      // These variables will used to store time values
      unsigned long lastmoved;
      unsigned long currenttime;
      float threshold = 2000;  
      
      void setup() {   
      Serial.begin(9600);
      myservo.attach(9);  // attaches the servo on pin 9 to the servo object 
      lastmoved=millis();  // defines the lastmoved variable as a time variable
      }  

      void loop() {
            val = analogRead(potpin);  // reads the value of the potentiometer (value between 1023 and 0)
            currenttime = millis(); 
            unsigned long offset = currenttime-lastmoved;
            
            //  if the value of the potentiometer is greater then 200 'also meaning is covered' AND 
            //  the offset is greater then the threshold move to pos and stay for atleast 10 seconds
        if (val > 200 && offset>threshold) {   
              val = map(val, 1023, 0, 180, 90);
              myservo.write(val);     // tell servo to go to position in variable 'pos' 
              lastmoved = currenttime;
              delay(15);
              Serial.println("1");  // Print 1 when the servo is in the raised position
              }
                  
        else {
              if (offset>threshold){
              val = map(val, 1023, 0, 180, 90);
              myservo.write(0);  // Moves the servo back to position 0
              Serial.println("0");  // Print 0 when the servo is in the 'neautral' position
                  }
             }
      
      }
