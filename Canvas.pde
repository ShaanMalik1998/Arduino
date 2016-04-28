Button lineButton;   // Buttons for tools.
Button fillButton;
Button circleButton;
Button squareButton;
Button eraserButton;
Button fireworksButton;
Button spiralButton;
Button armaButton;
///////////////////////////////////////////////
ArrayList fireworks; //Arraylist for the fireworks brush
int shapeSize = 10; // size of circles, squares, etc.
int canvasSize = 700; // size of the canvas
int mode = 1; //0 for line, 1 for fill, 2 for ellipse, 3 for square, 4 for eraser, 5 for fireworks, 6 for spiral, 7 for armageddon. 
color paint = color(0, 0, 0); // fill colour for the canvas.
Colortab[] colours = new Colortab[8]; //Buttons you click to change the color.
Circle myCircle; // Circle objects
Square mySquare; // Square objects
Spiral mySpiral; // Spiral objects
//////////////////////////////////////////////



void setup() {
  frameRate(120); // speed up the framerate
  size(1200, 800);
  background(255);
  stroke(0);
  fill(255);
  rect(250, 50, canvasSize, canvasSize); // Draw the canvas
  ///////////////////////////////////////////////
  colours[0] = new Colortab(255, 0, 0, 10, 50); // redvalue, greenvalue, bluevalue, xPos, yPos.
  colours[1] = new Colortab(255, 128, 0, 35, 50); //orange
  colours[2] = new Colortab(255, 255, 0, 60, 50); //yellow
  colours[3] = new Colortab(0, 255, 0, 85, 50); // green
  colours[4] = new Colortab(0, 0, 255, 110, 50); // blue
  colours[5] = new Colortab(255, 0, 255, 135, 50); // purple
  colours[6] = new Colortab(0, 0, 0, 160, 50); // black
  colours[7] = new Colortab(255, 255, 255, 185, 50); //white
  //////////////////////////////////////////////////////////////
  lineButton = new Button(1000, 150, 1000, 170, 0, "Line"); //Buttons you click to change brushes,
  fillButton = new Button(1000, 100, 1000, 120, 1, "Fill"); //Click this to change mode to fill.
  circleButton = new Button(1000, 200, 1000, 220, 2, "Circle");
  squareButton = new Button(1000, 250, 1000, 270, 3, "Square");
  eraserButton = new Button(1000, 300, 1000, 320, 4, "Erase");
  fireworksButton = new Button(1000, 350, 1000, 370, 5, "Fireworks");
  spiralButton = new Button(1000, 400, 1000, 420, 6, "Spiral");
  armaButton = new Button(1000, 450, 1000, 470, 7, "Armageddon");
}
///////////////////////////////////////////////////////////////////

void draw() {
  textSize(20);
  noStroke();
  fill(255);
  rect(0, 0, width, 49); //Redraw the background around the canvas.
  rect(0, 0, 250, height);
  rect(0, 751, width, height-751);
  rect(951, 0, width-951, height);


/////////////////////////////////////////////////////////

  if (mode == 0) {
    stroke(paint);
    if (mousePressed && mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {

      line(mouseX, mouseY, pmouseX, pmouseY); //draws a continuous line
    }
  } else if (mode == 1) { //Different action based on the mode.
    stroke(0);
    fill(paint);
    if (mousePressed && mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      rect(250, 50, 700, 700); // fill the canvas the selected color.
    }
  } else if (mode == 4) {
    if (mousePressed && mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      fill(255);
      stroke(255);
      ellipse(mouseX, mouseY, shapeSize*2, shapeSize*2);
    }
  } else if (mode == 5) {
    if (mousePressed && mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      fill(paint);
      stroke(paint);
      for (int i = 0; i < fireworks.size (); i++) { //Arraylist code for fireworks brush.
        Fire mb = (Fire) fireworks.get(i);
        mb.run();
      }


      Fire myFire = new Fire(mouseX, mouseY, shapeSize); //Run the entire arraylist.

      fireworks.add(myFire); //Add a firework to the arraylist.
    }
  } else if (mode == 6) {
    if (mousePressed && mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      fill(paint);
      stroke(paint);
      mySpiral.run();
    }
  }
///////////////////////////////////////////////////////////////////////////////



  noFill();
  stroke(0);
  rect(250, 50, canvasSize, canvasSize); //  Redraw the canvas border.
  fill(0);
  text("Size: ", 20, 100); //Displays the shape size.
  text(shapeSize, 80, 100);
  ////////////////////////////////////////
  
  for (int j = 0; j < 8; j++) {
    colours[j].run(); //Draws the colortabs
  }
  lineButton.run(); //Run each button.
  fillButton.run();
  circleButton.run();
  squareButton.run();
  eraserButton.run();
  fireworksButton.run();
  spiralButton.run();
  armaButton.run();
}

////////////////////////////////////////////////


void mouseClicked() {
  if ( mode == 2) {
    myCircle = new Circle(500, 500, shapeSize);
    stroke(0);
    fill(paint);
    myCircle.setLocation();
    myCircle.display(); //Draw circle in canvas
  } else if (mode == 3) {
    mySquare = new Square(500, 500, shapeSize*2);
    stroke(0);
    fill(paint);
    mySquare.setLocation();
    mySquare.display(); //Draw square in the canvas
  } else if (mode == 7) {
    if (mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      armageddon();  // ?
    }
  }
}
///////////////////////////////////////////////////////////////////

void mouseWheel(MouseEvent event) { //mouseWheel syntax.
  float e = event.getCount(); // e = read of mouseWheel.
  if (shapeSize < 350 && e < 0) { 
    shapeSize += -1*e; //Size goes up as mouseWheel goes up.
  } else if (shapeSize > 0 && e > 0) {
    shapeSize += -1*e; //Vise-Versa.
  }
}
/////////////////////////////////////////////////////////////////

void mousePressed() {
  if (mode == 5) {
    if (mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      fireworks = new ArrayList(); //generate an arraylist of fireworks.
    }
  } else if (mode == 6) {
    if (mouseX > 250 && mouseX < 950 && mouseY > 50 && mouseY < 750) {
      mySpiral = new Spiral(shapeSize*2); //generate a new spiral.
    }
  }
}
//////////////////////////////////////////////////////////////////////////

void keyPressed() {
  if (key == 'z') { //press z to save.
    saveFrame("paintFile.png"); //Change the file name if you want to keep your previous image.
  }
}


void armageddon() { // Randomized circles and squares.

    for (int j = 0; j < 100; j++) {
      fill(int(random(255)), int(random(10)), int(random(10)));
      stroke(int(random(255)), int(random(50)), int(random(50)));
      ellipse(random(250, 950), random(50, 750), random(100), random(100));
      rect(random(250, 950), random(50, 750), random(100), random(100));
    }
    
  }