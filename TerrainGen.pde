
int w = 2000;
int h = 1600;
int cols, rows;
int scl = 17;
float flying = 0;
boolean wActive = false;
boolean sActive = false;
boolean aActive = false;
boolean dActive = false;
boolean qActive = false;
boolean eActive = false;
boolean fastActive = false;
boolean slowActive = false;
float Ydirection = 0;
float Zdirection = 0;

//TO DO LIST: AIRPLANE SIMULATOR: INCLUDE PITCH/YAW/SPEED CONTROL
//@%$&@$%Y$ %BRDTFHVDGHVDFGHVDFTHBDFHR

//MAKE THESE INTO ADJUSTABLE BUTTONS
double flySpeed = 0.1;
float pitch = PI/3;
float[][] terrain;

void setup() {
  size(1080, 720, P3D);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}
void draw() {

  background(0);
  flying -= flySpeed;
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -15, 10+100/(20*(int)(sin(x))^2+1));
      xoff += 0.2;
    }
    yoff += 0.2;
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
      vertex(x*scl, y*scl, terrain[x][y]);
      vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
    }
    endShape();
  }
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
  
  if (fastActive)
  {
    flySpeed *= 1.005;
  }
  if (slowActive)
  {
    flySpeed *= 0.995;
  }
}
void keyPressed() {
  if (keyCode == 'S')
  {
    wActive = true;
  } 
  if (keyCode == 'W')
  {
    sActive = true;
  }
  if (keyCode == 'A')
  {
    aActive = true;
  } 
  if (keyCode == 'D')
  {
    dActive = true;
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
}

void keyReleased() {
  if (keyCode == 'S')
  {
    wActive = false;
  }
  if (keyCode == 'W')
  {
    sActive = false;
  }
  if (keyCode == 'A')
  {
    aActive = false;
  } 
  if (keyCode == 'D')
  {
    dActive = false;
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
}
