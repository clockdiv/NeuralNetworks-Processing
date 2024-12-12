float LEARNING_RATE = 0.01;

class Neuron {
  Neuron[] inputs;
  float[] weights;
  float output;
  float error;


  Neuron() {
    error = 0.0;
  }


  Neuron(Neuron[] prev_inputs) {
    inputs = new Neuron[prev_inputs.length];
    weights = new float[prev_inputs.length];
    error = 0.0;
    for(int i = 0; i < prev_inputs.length; i++) {
       inputs[i] = prev_inputs[i];
       weights[i] = random(-1.0, 1.0);
    }
  }
  
  
  void respond() {
    println("respond");
    float input = 0.0;
    for(int i = 0; i < inputs.length; i++) {
      input += inputs[i].output * weights[i];
    }
    print(input + " ---- ");
    output = lookupSigmoid(input);
    println(output);
    error = 0.0;
  }
  
  void setError(float desired) {
    error = desired;// - output;
  }
  
  void train() {
    float delta = (1.0 - output) * (1.0 + output) * error * LEARNING_RATE;
    for(int i = 0; i < inputs.length; i++) {
       inputs[i].error += weights[i] * error;
       weights[i] += inputs[i].output * delta;
    }
  }
}
