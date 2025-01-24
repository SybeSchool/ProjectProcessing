#define PotPin A0
#define PotInterval 100

#define RedLed 2
#define OrangeLed 3
#define GreenLed 4


int potVal;
unsigned long start;
unsigned long previousTime;
char valFromProcessing;

void setup() {
  // put your setup code here, to run once:
  pinMode(RedLed, OUTPUT);
  pinMode(OrangeLed, OUTPUT);
  pinMode(GreenLed,  OUTPUT);

  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  start = millis();
  if(valFromProcessing != 0 && (start - previousTime) >= PotInterval){
    potVal = analogRead(PotPin);
    Serial.println(potVal);
    delay(100);
    previousTime = millis();
  }

  if(Serial.available()){
    valFromProcessing = Serial.read();
  }
  if(valFromProcessing == 3){
    digitalWrite(RedLed, HIGH);
    digitalWrite(OrangeLed, HIGH);
    digitalWrite(GreenLed, HIGH);
  }
  if(valFromProcessing == 2){
    digitalWrite(RedLed, HIGH);
    digitalWrite(OrangeLed, HIGH);
    digitalWrite(GreenLed, LOW);
  }
  if(valFromProcessing == 1){
    digitalWrite(RedLed, HIGH);
    digitalWrite(OrangeLed, LOW);
    digitalWrite(GreenLed, LOW);
  }
}
