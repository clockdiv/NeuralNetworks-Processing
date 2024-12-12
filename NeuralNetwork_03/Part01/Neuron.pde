
class Neuron {
  float m_output;
  void display() {

    fill(128 * (1-m_output));
    ellipse(0, 0, 16, 16);
  }
}
