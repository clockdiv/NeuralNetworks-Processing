// Version 01 should be the one trained manually with the mouse

Perceptron p;

float[] inputs = {0, 0, 1};  // x, y, bias

void setup() {
  size(600, 600);
  background(255);
  p = new Perceptron();
  p.initWeights(inputs.length);
  redraw();
}


void draw() {
  //  background(255);
}


void mousePressed()
{
  float[] in = {mouseX, mouseY, 1};
  if (mouseButton == LEFT) {
    p.train(in, 0);
  } else if (mouseButton == RIGHT) {
    p.train(in, 1);
  }

  redraw();
}


void keyPressed() {
  if (key == 'r')
  {
    p.initWeights(inputs.length);
    redraw();
  }
}

void redraw(){
    background(255);
    p.testWeights();
    p.printWeights();
    drawFunction();
}


void drawFunction()
{
  for (float x = 0; x < width; x+=3)
  {
    fill(99);
    ellipse(x, f(x), 1, 1);
  }
}


float f(float x) {
  //return pow(x/width*20, 3);
  //return sin(x / width * 8) * height/4;
  return 1 * x + 0;
}
