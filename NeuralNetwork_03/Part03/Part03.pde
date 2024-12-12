
int testCard = 0;
int trainCard = 0;
int totalTrain = 0;
int totalTest = 0;
Network neuralnet;
Card[] testing_set;    // will have 8000 cards
Card[] training_set;   // will have 2000 cards

void setup()
{
  size(1000, 400);
  setupSigmoid();
  loadData();          // fill testing_set and training_set
  neuralnet = new Network(196, 49, 10);  // 196 inputs
  smooth();
  stroke(150);
}


void draw()
{
  //neuralnet.respond(testing_set[cardNum]);
  background(255);
  neuralnet.display();

  fill(100);
  text("Test card: #" + testCard, width*0.18, height*0.89);
  text("Train card: " + trainCard, width*0.18, height*0.93);
  
  text("Total train: " + totalTrain, width*0.32, height*0.89);
  text("Total test: " + totalTest, width*0.32, height*0.93);
  
//  if(totalTest>0) sucess = float(totalRight)/float(totalTest);
//  text("Success rate: " + nfc(sucess, 2), width*0.44, height*0.89);
  text("Card label: " + testing_set[testCard].output, width*0.44, height*0.93);
}


void mousePressed() {
  // cardNum = int(random(2000));
  if (mouseButton == LEFT) {
    for(int i = 0; i < 500; i++) {
      trainCard = (int) floor(random(0, training_set.length));
      neuralnet.respond(training_set[trainCard]);
      neuralnet.train(training_set[trainCard].outputs);
      totalTrain++;
    }
  } 
    testCard = (int) floor(random(0, testing_set.length));
    neuralnet.respond(testing_set[testCard]);
    totalTest++;
  redraw();
}


void loadData() {
  byte[] images = loadBytes("t10k-images-14x14.idx3-ubyte"); 
  byte[] labels = loadBytes("t10k-labels.idx1-ubyte");

  training_set = new Card[8000];
  int tr_pos = 0;

  testing_set = new Card[2000];
  int te_pos = 0;

  for (int i = 0; i< 10000; i++) {
    if (i % 5 != 0) {
      training_set[tr_pos] = new Card();
      training_set[tr_pos].imageLoad(images, 16 + i * 196);
      training_set[tr_pos].labelLoad(labels, 8 + i);
      tr_pos++;
    } else {
      testing_set[te_pos] = new Card();
      testing_set[te_pos].imageLoad(images, 16 + i * 196);
      testing_set[te_pos].labelLoad(labels, 8 + i);
      te_pos++;
    }
  }
}
