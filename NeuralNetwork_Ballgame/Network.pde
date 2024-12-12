class Network {
  Neuron[] input_layer;
  Neuron[] hidden_layer;
  Neuron output_layer;

  Network(int inputs, int hidden, int outputs) {
    input_layer = new Neuron[inputs];
    hidden_layer = new Neuron[hidden];

    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i] = new Neuron();
    }
    for (int i = 0; i < hidden_layer.length; i++) {
      hidden_layer[i] = new Neuron(input_layer);
    }
    output_layer = new Neuron(hidden_layer);
  }


  void respond(float[] inputs) {
    for (int i = 0; i < input_layer.length; i++) {
      input_layer[i].output = inputs[i];
    }
    for (int i = 0; i < hidden_layer.length; i++) {
      hidden_layer[i].respond();
    }
    output_layer.respond();
  }

  void train(float output) {
    output_layer.setError(output);
    output_layer.train();
    for(int i = 0; i < hidden_layer.length; i++) {
       hidden_layer[i].train(); 
    }
  }
}
