import ddf.minim.*;
AudioPlayer heli;
AudioPlayer radio;
Minim minim;

int w = 2000;
int h = 1600;
int cols, rows;
int scl = 17;
float flying = 0;
float flyingY = 0;
boolean wActive = false;
boolean sActive = false;
boolean aActive = false;
boolean dActive = false;
boolean qActive = false;
boolean eActive = false;
boolean fastActive = false;
boolean slowActive = false;
boolean rActive = false;
boolean fActive = false;
boolean leftActive = false;
boolean rightActive = false;
float Ydirection = 0;
float Zdirection = 0;
float myHeight = 0;
float turnValue = 0;
float turnChange = 0;
PImage image1;
int count = 0;
float flySpeed = 0.3;
float pitch = PI/3;
float[][] terrain;

void setup() {
  size(1080, 720, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
  image1 = loadImage("image1.png");

  minim = new Minim(this);
  heli = minim.loadFile("sound1.mp3", 256);
  radio = minim.loadFile("sound2.mp3", 256);
  heli.loop();
}
void draw() {
  count++;
  if (count % 20000 == 200)
    radio.rewind();
  radio.play();
  background(0);

  flying -= 0.1*cos(0.01*turnValue)*flySpeed;
  flyingY -= 0.1*sin(0.01*turnValue)*flySpeed;
  float xoff = flying;
  for (int y = 0; y < rows; y++) {
    float yoff = flyingY;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -30, 30);
      yoff += 0.2f;
    }
    xoff += 0.2f;
  }

  noFill();
  translate(width/2, height/2+50);
  rotateX(pitch);
  rotateY(Ydirection);
  rotateZ(Zdirection);
  translate(-w/2, -h/2);
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < cols; x++) {
      stroke(0.003*y*y+0.0003*(x-300)*(x-300));  //FOG
      fill(19, 80, 17);
      vertex(x*scl, y*scl, terrain[x][y]+myHeight);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]+myHeight);
    }
    endShape();
  }
  //Water
  fill(72, 61, 139);
  //rect(0,0,3000,2000,1100);
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  fill(150);
  image(image1, 0, 0, 1080, 720);
  textSize(18);
  text("PITCH: " + round(pitch*70), 30, 10 + textAscent());
  text("YAW: " + round(Zdirection*70), 30, 35 + textAscent());
  text("ROLL: " + round(Ydirection*70), 30, 60 + textAscent());
  text("FPS "+round(frameRate), 30, 85 + textAscent());
  hint(ENABLE_DEPTH_TEST);

  if (wActive)
  {
    if (pitch < PI/2 - 0.05)
      pitch += 0.01;
  } else if (sActive)
  {
    if (pitch > 0)
      pitch -= 0.01;
  }

  if (aActive)
  {
    if (Ydirection < PI/2-0.5)
      Ydirection += 0.01;
  } else if (dActive)
  {
    if (Ydirection > -PI/2+0.5)
      Ydirection -= 0.01;
  }
  if (qActive)
  {
    Zdirection += 0.01;
  } else if (eActive)
  {
    Zdirection -= 0.01;
  }
  if (rActive)
  {
    if (myHeight < 500)
    myHeight += 5;
  } else if (fActive) 
  {
    if (myHeight > 0)
    myHeight-= 5;
  }
  if (fastActive)
  {
    flySpeed *= 1.005;
  }
  if (slowActive)
  {
    flySpeed *= 0.995;
  }
  if (leftActive)
  {
    turnChange += 1;
  }
  if (rightActive)
  {
    turnChange -= 1;
  }
  turnValue = turnChange;
}

///////////////////////////////////////////////////////////////////////////////////

void keyPressed() {
  if (keyCode == 'W')
  {
    wActive = true;
  } 
  if (keyCode == 'S')
  {
    sActive = true;
  }
  if (keyCode == 'A')
  {
    aActive = true;
    leftActive = true;
  } 
  if (keyCode == 'D')
  {
    dActive = true;
    rightActive = true;
  }
  if (keyCode == '=')
  {
    fastActive = true;
  }
  if (keyCode == '-')
  {
    slowActive = true;
  }
  if (keyCode == 'Q')
  {
    qActive = true;
  }
  if (keyCode == 'E')
  {
    eActive = true;
  }
  if (keyCode == SHIFT)
  {
    rActive = true;
  }
  if (keyCode == ' ')
  {
    fActive = true;
  }
  if (keyCode == LEFT)
  {
    rightActive = true;
  }
  if (keyCode == RIGHT)
  {
    leftActive = true;
  }
  if (keyCode == 'R')
  {
    pitch = 1.28;
    Ydirection = 0;
    Zdirection = 0;
    flying = 0;
    flyingY = 0;
    turnValue = 0;
    turnChange = 0;
  }
}

void keyReleased() {
  if (keyCode == 'W')
  {
    wActive = false;
  }
  if (keyCode == 'S')
  {
    sActive = false;
  }
  if (keyCode == 'A')
  {
    aActive = false;
    leftActive = false;
  } 
  if (keyCode == 'D')
  {
    dActive = false;
    rightActive = false;
  }
  if (keyCode == '=')
  {
    fastActive = false;
  }
  if (keyCode == '-')
  {
    slowActive = false;
  }
  if (keyCode == 'Q')
  {
    qActive = false;
  }
  if (keyCode == 'E')
  {
    eActive = false;
  }
  if (keyCode == SHIFT)
  {
    rActive = false;
  }
  if (keyCode == ' ')
  {
    fActive = false;
  }
  if (keyCode == LEFT)
  {
    rightActive = false;
  }
  if (keyCode == RIGHT)
  {
    leftActive = false;
  }
}
