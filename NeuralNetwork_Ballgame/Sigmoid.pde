float[] sigmoid = new float[200];

void setupSigmoid() {
  for (int i = 0; i < sigmoid.length; i++) {
    float x = (i / 20.0) - 5.0;
    sigmoid[i] = 2.0 / (1.0 + exp(-2.0 * x )) - 1.0;
  }
}



float lookupSigmoid(float x) {
  return sigmoid[constrain((int) floor((x + 5.0) * 20), 0, sigmoid.length-1)];
}
