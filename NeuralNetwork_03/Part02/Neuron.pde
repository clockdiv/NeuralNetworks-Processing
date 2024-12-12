
class Neuron {
  
  Neuron[] inputs;  // neurons from previous layer
  float[] weights;
  float output;


  Neuron() {}      // constructor for input layer
  
  
  Neuron(Neuron[] prev_inputs) {  // constructor for hidden/output layer
    inputs = new Neuron[prev_inputs.length];
    weights = new float[prev_inputs.length];
    for(int i = 0; i < prev_inputs.length; i++) {
      inputs[i] = prev_inputs[i];
      weights[i] = random(-1.0, 1.0);
    }
  }
  
  
  void respond() {
    float input = 0.0;
    for(int i = 0; i < inputs.length; i++) {
      input += inputs[i].output * weights[i]; 
    }
    output = lookupSigmoid(input);
  }
  
  
  void display() {
    fill(128 * (1 - output));
    ellipse(0, 0, 16, 16);
  }
}
