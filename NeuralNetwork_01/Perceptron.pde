class Perceptron { //<>// //<>//
  float[] weights;
  float c = 0.0001;

  PVector[] testData;

  Perceptron() {
    testData = new PVector[100];
    for (int i = 0; i < testData.length; i++) {
      testData[i] = new PVector();
      testData[i].x = random(0, width);
      testData[i].y = random(0, height);
    }
  }
  
  void initWeights(int n) {
    weights = new float[n];
    for (int i = 0; i < weights.length; i++)
    {
      //weights[i] = random (-1, 1);
      weights[i] = 0.5;
    }
  }


  float feedforward(float[] inputs) {
    float sum = 0;
    for (int i = 0; i < weights.length; i++) {
      sum += inputs[i] * weights[i];
    }
    return sum / weights.length;
    //    return activate(sum) ;
  }


  int activate(float sum) {
    if (sum > 0) return 1;
    else return 0;
  }


  void train(float[] inputs, int desired) {
    float guess = feedforward(inputs);
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
    for (int i = 0; i < testData.length; i++)
    {
      color[] c = {color(255, 0, 0), color(0, 255, 0)};
      float[] inputs = {testData[i].x, testData[i].y, 1};
      //noStroke();
      //fill(c[feedforward(inputs)]);
      fill(0);
      textSize(8);
      text(feedforward(inputs), testData[i].x, testData[i].y);
      fill((feedforward(inputs) + 1) * 127);
      ellipse(testData[i].x, testData[i].y, 8, 8);
    }
  }


  void printWeights() {
    fill(255);
    stroke(99);
    rect(15, 8, 170, 38);
    textSize(12);
    textAlign(LEFT);
    fill(99);
    for (int i = 0; i < weights.length; i++)
    {
      text("Weights["+i+"]: " + weights[i], 20, 20 + 10*i);
    }
  }
}
