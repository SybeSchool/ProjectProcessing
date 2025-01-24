import processing.serial.*;
Serial port;

float hoek;
int procent;
float input;

float cx = 10;
float cy = 10;
float r = 5;

int levens = 3;
boolean won= false;

void setup(){
  size(400, 600);
  port = new Serial(this, "COM3", 9600);
  port.bufferUntil('\n');
  UpdateLevens();
}

void draw(){
  fill(#00001a);
  rect(0, 0, 400, 150); 
  fill(#999999);
  rect(0, 150, 400, 450);
  
  procent = int(map(input, 0, 1023, 0, 100));
  
  drawDoolhof(procent);
  drawLamp(procent);
  
  noFill();
  stroke(255, 0, 0);
  ellipse(cx, cy, r * 2, r * 2);
  
  checkIntersections(cx, cy, r);
  
  checkPlayerPosition();  
  
  
 
}


void serialEvent(Serial port){
  input = float(port.readStringUntil('\n'));
}

void drawLamp(int brightness){
  noStroke();
  fill(#FFFF00, map(brightness, 0, 100, 0, 255));
  arc(150, 300, 200, 200, PI, TWO_PI);
  quad(50, 300, 250, 300, 200, 450, 100, 450);
  fill(#808080);
  rect(100, 450, 100, 50);
  arc(150, 500, 100, 100, 0, PI);
  
  if(levens > 0){
    if(won == true){
      fill(0, 408, 612, 204);
      textSize(50);
      text("YOU WON", 50, 200);
      text("Press r to restart", 50, 350);
      if(keyPressed){
        if(key == 'r'){
          levens = 3;
          won = false;
          cx = 10;
          cy = 10;
        }
    }
    }else{
      fill(0, 408, 612, 204);
      textSize(50);
      text("Levens over:" + levens, 50, 200);
    }
  }else if (levens <= 0){
    fill(0, 408, 612, 204);
    textSize(50);
    text("GAME OVER", 50, 200);
    text("Press r to restart", 50, 350);
    if(keyPressed){
      if(key == 'r'){
        levens = 3;
        cx = 10;
        cy = 10;
      }
    }
  }
}


void drawDoolhof(int brightness){  
  stroke(255);
  fill(#FFFF00);
  rect(0, 0, 30, 30);
  stroke(#FFFFFF, brightness);
  strokeWeight(4);
  line(30, 30, 80, 30);
  line(80, 30, 80, 60);
  line(80, 60, 55, 60);
  line(30, 80, 80, 80);
  
  line(110, 30, 155, 30);
  line(155, 30, 155, 0);
  
  line(30, 30, 30, 80);
  line(30, 100, 30, 120);
  line(30, 120, 50, 120);
  line(50, 120, 50, 150);
  line(30, 140, 30, 150); 
  
  line(30, 80, 60, 80);
  line(60, 80, 60, 100);
  line(60, 100, 80, 100);
  line(80, 100, 80, 80);
  line(80, 80, 80, 150);
  
  line(80, 80, 110, 80);
  line(110, 80, 110, 120);
  line(110, 120, 140, 120);
  
  
  line(140, 90, 140, 60); 
  line(140, 60, 185, 60);
  line(140, 90, 170, 90); 
  line(170, 90, 170, 150);
  line(185, 60, 185, 30);
  
  line(210, 30, 300, 30);
  line(240, 30, 240, 70);
  line(300, 30, 300, 120);
  line(300, 75, 400, 75);
  line(330, 75, 330, 30);
  line(360, 75, 360, 30);
  
  line(210, 60, 210, 120);
  line(210, 120, 250, 120);
  line(250, 120, 250, 150);
  
  line(235, 95, 270, 95);
  line(270, 95, 270, 150);
  
  line(330, 150, 330, 110);
  line(330, 110, 360, 110);
  
  fill(#FF0000);
  noStroke();
  rect(335, 115, 25, 35);
}

void checkIntersections(float cx, float cy, float r) {
  // List of line segments (start and end points)
  float[][] lines = {
    {30, 30, 80, 30},
    {80, 30, 80, 60},
    {80, 60, 55, 60},
    {30, 80, 80, 80},
    {110, 30, 155, 30},
    {155, 30, 155, 0},
    {30, 30, 30, 80},
    {30, 100, 30, 120},
    {30, 120, 50, 120},
    {50, 120, 50, 150},
    {30, 140, 30, 150},
    {30, 80, 60, 80},
    {60, 80, 60, 100},
    {60, 100, 80, 100},
    {80, 100, 80, 80},
    {80, 80, 80, 150},
    {80, 80, 110, 80},
    {110, 80, 110, 120},
    {110, 120, 140, 120},
    {140, 90, 140, 60},
    {140, 60, 185, 60},
    {140, 90, 170, 90},
    {170, 90, 170, 150},
    {185, 60, 185, 30},
    {210, 30, 300, 30},
    {240, 30, 240, 70},
    {300, 30, 300, 120},
    {300, 75, 400, 75},
    {330, 75, 330, 30},
    {360, 75, 360, 30},
    {210, 60, 210, 120},
    {210, 120, 250, 120},
    {250, 120, 250, 150},
    {235, 95, 270, 95},
    {270, 95, 270, 150},
    {330, 150, 330, 110},
    {330, 110, 360, 110}
};

  for (int i = 0; i < lines.length; i++) {
    float x1 = lines[i][0];
    float y1 = lines[i][1];
    float x2 = lines[i][2];
    float y2 = lines[i][3];

    if (circleTouchesLine(cx, cy, r, x1, y1, x2, y2)) {
      stroke(0, 255, 0); // Highlight the touching line in green
      line(x1, y1, x2, y2);
      delay(500);
      reduceLevens();
    }
  }
}

boolean circleTouchesLine(float cx, float cy, float r, float x1, float y1, float x2, float y2) {
  // Vector math to compute the shortest distance from the circle center to the line segment
  float dx = x2 - x1;  // de vectorafstand berekenen voor de lijn,  is de verandering in x-coördinaat tussen x2 en x1
  float dy = y2 - y1;  // de vectorafstand berekenen voor de lijn,  is de verandering in y-coördinaat tussen y2 en y1
  float lengthSquared = dx * dx + dy * dy;  // kwadrateren om geen wortel te moeten gebruiken

  float t = ((cx - x1) * dx + (cy - y1) * dy) / lengthSquared;     
  t = max(0, min(1, t));  // verander dit getal naar een waarde tussen 0 en 1

  float nearestX = x1 + t * dx; // bereken het dichtste punt van de lijn tov de speler
  float nearestY = y1 + t * dy; // bereken het dichtste punt van de lijn tov de speler

  float dist = dist(cx, cy, nearestX, nearestY); // bereken de afstand tussen het dichtste punt van de lijn en de speler(cirkel).
  return dist <= r;  // controleer of de afstand kleiner is dan de straal van de cirkel, zo ja geef true anders geef false.
}

void checkPlayerPosition(){
  if(keyPressed && levens > 0 && won == false){
    if(key == 'z'){
      cy = cy - 1;
    }
    if(key == 's'){
      cy = cy + 1;
    }
    if(key == 'q'){
      cx = cx - 1;
    }
    if(key == 'd'){
      cx = cx + 1;
    }
  }
  circle(cx, cy, 2*r);
  
  if(cx >= 395){ 
    cx = 394;
  }
  if(cx <= 5){
    cx = 6;
  }
  if(cy >= 145){
    cy = 144;
  }
  if(cy <= 5){
    cy = 6;
  }
  
  
  won = checkInsideRect(r, cx, cy, 335, 115, 360, 150);
}

void reduceLevens() {
  levens = levens - 1;
  cx = 10;
  cy = 10;
  UpdateLevens();
}

void UpdateLevens() {
  port.write(char(levens));
}
boolean checkInsideRect(float R, float Xc, float Yc,float X1, float Y1,float X2, float Y2){ //bron: https://www.geeksforgeeks.org/check-if-any-point-overlaps-the-given-circle-and-rectangle
  float Xn = max(X1, min(Xc, X2));
  float Yn = max(Y1, min(Yc, Y2));
 
  float Dx = Xn - Xc;
  float Dy = Yn - Yc;
  return (Dx * Dx + Dy * Dy) <= R * R;
}
