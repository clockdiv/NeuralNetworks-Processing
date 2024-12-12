


// Version 02 is thought to be the one with an automatic Trainer


Perceptron p;
Trainer[] training = new Trainer[300];

float[] inputs = {0, 0, 1};  // x, y, bias

float t = 0;

void setup() {
  frameRate(10000);
  size(600, 600);
  p = new Perceptron(inputs.length);

  // init "Trainers" with fixed position and given answer.
  for (int i = 0; i < training.length; i++)
  {
    float x = random(-width/2, width/2);
    float y = random(-height/2, height/2);
    int answer = 0;
    if (y < f(x)) answer = 1;
    training[i] = new Trainer(x, y, answer);
  }
  t = millis();
}



void draw() {
  frame.setTitle(str(frameRate) + "fps"); 
  for (int i = 0; i < training.length; i++)
  {
    p.train(training[i].inputs, training[i].answer);
  }

  // The App runs with maximum fps, but the redraw should 
  // only be done every 40ms (=25fps), as it is the slowest part
  if (millis() - t > 40) {
    pushMatrix();
    translate(width/2, height/2);
    background(255);
    p.testWeights();
    for (int i = 0; i < training.length; i++)
    {
      fill(255);
      stroke(222);
      ellipse(training[i].inputs[0], training[i].inputs[1], 20, 20);
      textSize(8);
      textAlign(CENTER, CENTER);
      fill(99);
      text(training[i].answer, training[i].inputs[0], training[i].inputs[1]-2);
    }
    p.printWeights();
    drawFunction();
    t = millis();
    popMatrix();
  }
}


void mousePressed()
{
  // this was only for manual training
  float[] in = {mouseX, mouseY, 1};
  println(in);
  if (mouseButton == LEFT) {
    p.train(in, 0);
  } else if (mouseButton == RIGHT) {
    p.train(in, 1);
  }
}


void keyPressed() {
  // reset the weights
  if (key == 'r')
  {
    p = new Perceptron(inputs.length);
  }
}


void drawFunction()
{
  for (float x = -width/2; x < width/2; x++)
  {
    fill(99);
    ellipse(x, f(x), 1, 1);
  }
}


float f(float x) {
  //return pow(x/width*20, 3);
  //return sin(x / width * 8) * height/4;
  return 3.5 * x + 50;
}
