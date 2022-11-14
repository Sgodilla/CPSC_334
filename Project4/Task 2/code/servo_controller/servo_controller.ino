#include <Servo.h>

Servo servo1;
Servo servo4;
Servo servo5;
Servo servo6;
Servo servo7;
Servo servo8;

void setup() {
  Serial.begin(115200);

  servo1.attach(5); //D1
  servo4.attach(2); //D4
  servo5.attach(14); //D5
  servo6.attach(12); //D6
  servo7.attach(13); //D7
  servo8.attach(15) // D8
  Serial.println("Servo attached!");

  servo1.write(90);
  servo2.write(90);
  servo4.write(90);
  servo5.write(90);
  servo6.write(90);
  servo7.write(90);
  Serial.println("Servo initialized!");

  delay(2000);

}

void loop() {

  servo1.write(30);
  servo2.write(30);
  servo4.write(30);
  servo5.write(30);
  servo6.write(30);
  servo7.write(30);
  Serial.println("Servo 30 degrees!");

  delay(1000);

  servo1.write(120);
  servo2.write(120);
  servo4.write(120);
  servo5.write(120);
  servo6.write(120);
  servo7.write(120);
  Serial.println("Servo 120 degrees!");

  delay(1000);

}