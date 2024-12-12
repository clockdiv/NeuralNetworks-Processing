class Perceptron {

  float[] weights;
  float c = 0.001;
  float[] sigmoid = new float[200];

  ArrayList<data> dataset = new ArrayList<data>();


  Perceptron(int n) {
    setupSigmoid();

    weights = new float[n];
    for (int i = 0; i < weights.length; i++) {
      weights[i] = random (-1, 1);
    }
  }



  void setupSigmoid() {
    for (int i = 0; i < sigmoid.length; i++) {
      float x = (i / 20.0) - 5.0;
      sigmoid[i] = 2.0 / (1.0 + exp(-2.0 * x )) - 1.0;
    }
  }



  float lookupSigmoid(float x) {
    return sigmoid[constrain((int) floor((x + 5.0) * 20), 0, sigmoid.length-1)];
  }



  void drawSigmoid() {
    pushMatrix();
    translate(width/2, height/2);

    for (float i = -10; i < 10; i+=0.1) {
      line(i*20, 0, i*20, lookupSigmoid(i)*50);
    }
    popMatrix();
  }

  void drawDataset() {
    pushMatrix();
    translate(width/2, height/2);
    //scale(4, 4);
    
    stroke(244);
    for(int i = -25; i < -15; i++) {
      line(-50, i*4, 50, i*4);
    }
    stroke(222);
    line(0, -50, 0, 50);
    line(-50, 0, 50, 0);

    for (int i = 0; i < dataset.size(); i++) {
      dataset.get(i).display();
    }
    popMatrix();
    if(dataset.size()>0) text("latest error" + dataset.get(dataset.size()-1).error + "\ndataset size: " + dataset.size(), width/2 + 50, height/2);
  }


  float feedforward(float[] inputs) {
    float sum = 0;
    for (int i = 0; i  < weights.length; i++) {
      sum += inputs[i] * weights[i];
    }
    return lookupSigmoid(sum);
  }



  /*int activate(float sum) {
   if (sum > 0) return 1;
   else return 0;
   }*/



  void train(float[] inputs, float error) {
    for (int i = 0; i < weights.length; i++) {
      weights[i] += c * error * inputs[i];
    }
    dataset.add(new data(inputs, error));
  }
}



class data {
  float[] inputs;
  float error;

  data(float[] _inputs, float _error) {
    inputs = new float[_inputs.length];
    arrayCopy(_inputs, inputs);
    error = _error;
  }

  void display() {
    noStroke();
    fill(map(abs(error),0, 1000, 0, 255), map(abs(error),0, 1000, 255, 0), 0);
    ellipse(inputs[0]*4, inputs[1]*4, 2, 2);
  }
}
