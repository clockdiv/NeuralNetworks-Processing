class Network {

  Neuron[] input_layer;
  Neuron[] hidden_layer;
  Neuron[] output_layer;
  int bestIndex = 0;

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

    float [] resp = new float [output_layer.length];
    float respTotal = 0.0;
    for (int k = 0; k < output_layer.length; k++) {
      resp[k] = output_layer[k].output;
      respTotal += resp[k]+1;
    }

    for (int k = 0; k < output_layer.length; k++) {
      pushMatrix();
      translate(width * 0.85, (k%10) * height / 15.0 + height * 0.2);
      output_layer[k].display();
      fill(150);
      strokeWeight(sq(output_layer[k].output)/2);
      line(12, 0, 25, 0);
      text(k%10, 40, 5);
      text(nfc(((output_layer[k].output+1)/respTotal)*100, 2) + "%", 55, 5);
      popMatrix();
      strokeWeight(1);
    }
    float best = -1.0;
    for (int i =0; i < resp.length; i++) {
      if (resp[i]>best) {
        best = resp[i];
        bestIndex = i;
      }
    }
    stroke(255, 0, 0);
    noFill();
    ellipse(
      width * 0.85, (bestIndex%10) * height / 15.0 + height * 0.2, 
      25, 25);
  }


  void train(float[] outputs) {
    for (int i = 0; i < output_layer.length; i++) {
      output_layer[i].setError(outputs[i]);
      output_layer[i].train();
    }
    /*
    float best = -1.0;
     
     for(int i = 0; i < output_layer.length; i++) {
     if(output_layer[i].output > best) bestIndex = i;
     }*/

    for (int i = 0; i < hidden_layer.length; i++) {
      hidden_layer[i].train();
    }
  }

}
