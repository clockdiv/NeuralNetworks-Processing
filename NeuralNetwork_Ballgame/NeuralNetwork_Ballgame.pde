
//Perceptron p;
Ball ball;
PVector serve, goal, force;
float goalSize = 50, serveSize = 20, error = 0;
float[] inputs = {0, 0};
int shots = 0;
boolean istrained = false;
int mode = 0;   // 0 = training, 1 = throwing

Network neuralnet;

void setup() {
  frameRate(120);
  size(600, 600);
  smooth();

  serve = new PVector(width/8, height-height/8);
  goal =  new PVector(width/1.2, height-height/8);
  force = new PVector();
  ball = new Ball();
  //p = new Perceptron(inputs.length);
  neuralnet = new Network(2, 2, 1);
}



void draw() {
  background(255);
  fill(127);
  textAlign(LEFT);
  text("Error: " + error + "\ninputs[0]: " + inputs[0] + "\ninputs[1]: " + inputs[1] +"\nshots: " + shots, 20, 20);
  text("\ninput_layer[0] output: " + neuralnet.input_layer[0].output +
  "\ninput_layer[1] output: " + neuralnet.input_layer[1].output +
  "\nhidden_layer[0] output: " + neuralnet.hidden_layer[0].output +
  "\nhidden_layer[1] output: " + neuralnet.hidden_layer[1].output +
  "\noutput_layer output: " + neuralnet.output_layer.output + 
  "\nhidden_layer[0] weights: " + neuralnet.hidden_layer[0].weights[0] + " - " + neuralnet.hidden_layer[0].weights[1] +
  "\nhidden_layer[1] weights: " + neuralnet.hidden_layer[1].weights[0] + " - " + neuralnet.hidden_layer[1].weights[1] +
  "\noutput_layer weights: " + neuralnet.output_layer.weights[0] + " - " + neuralnet.output_layer.weights[1]
  , 180, 20);
  switch (mode) {
  case 0:
    textAlign(CENTER);
    text("Training", width/2, 20);
    textAlign(LEFT);
    if (ball.pos.dist(serve) < ball.size/2) {
      inputs[0] = random(2, 12);
      inputs[1] = random(-15, -10);
      force = new PVector(inputs[0], inputs[1]);
      ball.applyForce(force);
    }
    ball.update();
    ball.display();
    //p.drawDataset();
    if (abs(goal.y - ball.pos.y) < 5 && !istrained) {
      error = ball.pos.dist(goal);
      if (goal.x < ball.pos.x) error *= -1;
      //p.train(inputs, error);
      istrained = true;
    }

    if (ball.pos.y > height && istrained == true) {
      for(int i = 0; i < inputs.length; i++) {
         inputs[i] = constrain(map(inputs[i], -20, 20, 0, 1), 0, 1); 
      }
      
      neuralnet.respond(inputs);
      error = constrain(map(error, -500, 500, -1, 1), -1, 1);
     
      neuralnet.train(error);
      ball = new Ball();
      shots++;
      istrained = false;
    }
    break;
    
    
  case 1:
    textAlign(CENTER);
    text("Throwing", width/2, 20);
    textAlign(LEFT);
    break;
  }

  drawScene();
}




void drawScene() {
  fill(127);
  pushMatrix();
  translate(serve.x, serve.y);
  stroke(127);
  line(-serveSize, 0, serveSize, 0);
  popMatrix();

  pushMatrix();
  translate(goal.x, goal.y);
  ellipse(0, 0, goalSize, goalSize);
  popMatrix();
}
