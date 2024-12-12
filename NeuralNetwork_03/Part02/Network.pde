class Network {

  Neuron[] input_layer;
  Neuron[] hidden_layer;
  Neuron[] output_layer;


  Network(int inputs, int hidden, int outputs) {    // each integer determines the size of the layer
    input_layer = new Neuron[inputs];
    hidden_layer = new Neuron[hidden];
    output_layer = new Neuron[outputs];

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i] = new Neuron();
    }

    for (int i = 0; i < hidden_layer.length; i++) {
      hidden_layer[i] = new Neuron(input_layer);
    }

    for (int i = 0; i < output_layer.length; i++) {
      output_layer[i] = new Neuron(hidden_layer);
    }
  }


  void respond(Card card) {
    float[] responses = new float[output_layer.length];
    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i].output = card.inputs[i];
    }
    for (int i = 0; i < hidden_layer.length; i++) {
      hidden_layer[i].respond();
    }
    for (int i = 0; i < output_layer.length; i++) {
      output_layer[i].respond();
    }
  }


  void display() {
    // input layer
    for (int i = 0; i < input_layer.length; i++) {
      pushMatrix();
      translate((i%14) * height / 20.0 + width * 0.06, (i/14) * height / 20.0 + height * 0.16);
      input_layer[i].display();
      popMatrix();
    }

    // hidden layer
    for (int i = 0; i < hidden_layer.length; i++) {
      pushMatrix();
      translate((i%7) * height / 20.0 + width * 0.53, (i/7) * height / 20.0 + height * 0.32);
      hidden_layer[i].display();
      popMatrix();
    }
    
    // output layer
    for (int i = 0; i < output_layer.length; i++) {
      pushMatrix();
      translate(width * 0.9, ((i + 9) % 10) * height / 20.0 + height * 0.24);
      output_layer[i].display();
      popMatrix();
    }
    
  }
}
