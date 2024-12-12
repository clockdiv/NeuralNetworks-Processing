class Perceptron { //<>// //<>//

  float[] weights;
  float c = 0.000001;


  Perceptron(int n) {
    weights = new float[n];
    for (int i = 0; i < weights.length; i++)
    {
      weights[i] = random (-1, 1);
    }
  }


  int feedforward(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < weights.length; i++) {
      sum += inputs[i] * weights[i];
    }
    return activate(sum) ;
  }
  

  int activate(float sum) {
    if (sum > 0) return 1;
    else return 0;
  }


  void train(float[] inputs, int desired) {
    int guess = feedforward(inputs);
    float error = desired - guess;
    for (int i = 0; i < weights.length; i++)
    {
      weights[i] += c * error * inputs[i];
    }
  }


  // this functions simply draws little 
  // green and red dots on random 
  // positions to test the weights. 
  void testWeights() {
    for (int i = 0; i < 10000; i++)
    {
      float x = random(-width/2, width/2);
      float y = random(-height/2, height/2);
      color[] c = {color(255, 0, 0), color(0, 0,255)};
      float[] inputs = {x, y, 1};
      noStroke();
      fill(c[feedforward(inputs)]);
      ellipse(x, y, 1,1);
    }
  }
  
  void printWeights() {
    fill(255);
    stroke(99);
    rect(-width/2+15, -height/2+8, 170, 38);
    textSize(12);
    textAlign(LEFT);
    fill(99);
    for (int i = 0; i < weights.length; i++)
    {
      text("Weights["+i+"]: " + weights[i], -width/2+20, -height/2+20 + 10*i);
    }
  }
}
