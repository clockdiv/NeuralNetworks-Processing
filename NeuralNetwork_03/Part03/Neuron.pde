
float LEARNING_RATE = 0.01;

class Neuron {

  Neuron[] inputs;  // neurons from previous layer
  float[] weights;
  float output;
  float error;


  Neuron() {        // constructor for input layer
    error = 0.0;
  }      


  Neuron(Neuron[] prev_inputs) {  // constructor for hidden/output layer
    inputs = new Neuron[prev_inputs.length];
    weights = new float[prev_inputs.length];
    error = 0.0;
    for (int i = 0; i < prev_inputs.length; i++) {
      inputs[i] = prev_inputs[i];
      weights[i] = random(-1.0, 1.0);
    }
  }


  void respond() {
    float input = 0.0;
    for (int i = 0; i < inputs.length; i++) {
      input += inputs[i].output * weights[i];
    }
    output = lookupSigmoid(input);
    error = 0.0;
  }

  void setError(float desired) {
    error = desired - output;
  }

  void train() {
    float delta = (1.0 - output) * (1.0 + output) * error * LEARNING_RATE;
    for (int i = 0; i < inputs.length; i++) {
      inputs[i].error += weights[i] * error; 
      weights[i] += inputs[i].output * delta;
    }
  }

  void display() {
    stroke(200);
    fill(128 * (1 - output));
    ellipse(0, 0, 16, 16);
  }

  float [] getStrength() {
    float ind = 0.0;
    float str = 0.0;
    for (int i = 0; i < weights.length; i++) {
      if (weights[i] > str) {
        ind = i; 
        str = weights[i];
      }
    }
    float [] a = {ind, str};
    return a;
  }
}
