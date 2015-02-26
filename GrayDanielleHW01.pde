//created by Danielle Gray on 1/31/2015

int w = 0; 
int b = -1; 
int s = 1; 
int a = 256; 

color currentStroke;
int currentWeight;
boolean crazy = false;

Palette[] palette = new Palette[10];
color[] theColors = new color[10];

PImage plus;
PImage minus;
PImage eraser;
PImage save;
PImage clear;
PImage rainbow;
PImage stroke;
PImage opacity;

void setup()
{   
  size(1000, 700);
  background(255);

  //toolbar
  noStroke();
  fill(#EDEBEB);
  rect(0, height - 50, width, height - 50);

  //color gallery
  theColors[0] = color(255, 0, 0);
  theColors[1] = color(255, 127, 0);
  theColors[2] = color(255, 255, 0);
  theColors[3] = color(128, 185, 18);
  theColors[4] = color(20, 141, 198);
  theColors[5] = color(115, 8, 97);
  theColors[6] = color(194, 15, 104);
  theColors[7] = color(205, 133, 63);
  theColors[8] = color(0);
  theColors[9] = color(255);

  //color palette
  stroke(255);
  createPalette();
  stroke(0);

  //buttons
  plus = loadImage("Images/plus.png");
  minus = loadImage("Images/minus.png");
  eraser = loadImage("Images/eraser.png");
  save = loadImage("Images/save.png");
  clear = loadImage("Images/clear.png");
  rainbow = loadImage("Images/rainbow.png");
  stroke = loadImage("Images/stroke.png");
  opacity = loadImage("Images/opacity.png");
  
  image(eraser, 9*35+15, height-35, 26, 26);
  image(minus, 375, height - 35, 25, 25);
  image(stroke, 403, height - 34, 80, 25);
  image(plus, 485, height - 35, 25, 25);

  image(minus, 525, height - 35, 25, 25);
  image(opacity, 553, height - 34, 80, 25);
  image(plus, 635, height - 35, 25, 25);

  image(save, width - 40, height - 35, 25, 25);
  image(clear, width - 70, height - 35, 25, 25);
  image(rainbow, width - 100, height - 35, 25, 25);
}

void draw()
{
  //don't allow drawing on toolbar
  if (mousePressed && mouseY < height - 50 && pmouseY < height - 50)
  {
    //rainbow brush
    if (crazy) {
      stroke(random(255), random(255), random(255), a);
    } 
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
}

void keyPressed()
{
  //adjusting strokeWidth
  if (key == '[')
  {
    if (s - 5 > 0)
    {
      s -= 5;
    } else if (s - 5 < 0)
    {
      s = 1;
    }
  } else if (key == ']')
  {
    s+=15;
  }
  strokeWeight(s);

  //clear canvas shortcut
  if ( key=='c')
  {
    fill(255);
    noStroke();
    rect(0, 0, width, height-50);
    stroke(0);
  }
  
  //save shortcut
  if (key=='s')
  {
    saving();
  }
}

void mousePressed()
{
  //picking a color via color palette
  w = 35;
  for (int i = 0; i < palette.length; i++)
  {
    if (mouseX > (15 + (i * w)) && mouseX < ((15 + (i * w)) + 25)
      && mouseY > height-35 && mouseY < height - 10)
    {
      crazy = false;
      stroke(theColors[i], a);
    }
  }

   //adjusting stroke width via buttons
  if (mouseX > 375 && mouseX < 400
    && mouseY > height - 35 && mouseY < height - 10)
  {
    if (s - 1 > 0)
    {
      s -= 1;
    } else if (s - 1 < 0)
    {
      s = 1;
    }
    strokeWeight(s);
  } else if (mouseX > 485 && mouseX < 510
    && mouseY > height - 35 && mouseY < height - 10)
  {
    s+=1;
    strokeWeight(s);
  }

  //adjusting alpha via buttons
  if (mouseX > 525 && mouseX < 550
    && mouseY > height - 35 && mouseY < height - 10)
  {
    if (a - 30 > 0)
    {
      a -= 30;
    } else if (a - 1 < 0)
    {
      a = 0;
    }
    currentStroke = g.strokeColor;
    stroke(red(currentStroke), green(currentStroke), blue(currentStroke), a);
  } else if (mouseX > 635 && mouseX < 655
    && mouseY > height - 35 && mouseY < height - 10)
  {
    if (a + 30 <= 256)
    { 
      a+=30;
    } else if (a + 10 > 256)
    {
      a = 256;
    }
    currentStroke = g.strokeColor;
    stroke(red(currentStroke), green(currentStroke), blue(currentStroke), a);
  }

  //clearing the canvas via button
  if (mouseX > width - 70 && mouseX < width - 45
    && mouseY > height - 35 && mouseY < height - 10)
  {
    fill(255);
    noStroke();
    rect(0, 0, width, height-50);
    stroke(0);
  }

  //crazy brush via button
  if (mousePressed & mouseX > width - 100 && mouseX < width - 75
    && mouseY > height - 35 && mouseY < height - 10)
  {
    crazy = true;
  }

  //saving via button
  if (mouseX > width - 40 && mouseX < width - 15
    && mouseY > height - 35 && mouseY < height - 10)
  {
    saving();
  }
}

//create the color palette
void createPalette()
{
  for (int i = 0; i < palette.length; i++)
  {
    w += 35;
    b += 1;
    palette[i] = new Palette((-20 + w), (height - 35), 25, theColors[b]);
  }
}

//save image
void saving()
{
  //only save canvas part of the screen
  //save in a folder called 'masterpieces'
  //name picture using the data + time
  PImage saveImg = get(0, 0, width, height - 50);
  saveImg.save("Masterpieces/" + year() + "-" + nf(month(), 2) + "-" 
    + nf(day(), 2) + " @ "  + nf(hour(), 2) + "h" + nf(minute(), 2) 
    + "m" + nf(second(), 1) + "s.png");
}
