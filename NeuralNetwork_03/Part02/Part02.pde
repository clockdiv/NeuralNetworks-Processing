
int cardNum = int(random(2000));
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
  neuralnet.respond(testing_set[cardNum]);
  background(255);
  neuralnet.display();
  
  fill(100);
  text("Card number: #" + cardNum, width*0.05, height * 0.9);
  text("Card label: " + testing_set[cardNum].output, width* 0.05, height * 0.95);  
}


void mousePressed() {
 cardNum = int(random(2000)); 
}


void loadData() {
   byte[] images = loadBytes("t10k-images-14x14.idx3-ubyte"); 
   byte[] labels = loadBytes("t10k-labels.idx1-ubyte");
   
   training_set = new Card[8000];
   int tr_pos = 0;
   
   testing_set = new Card[2000];
   int te_pos = 0;
   
   for(int i = 0;  i< 10000; i++){
      if(i % 5 != 0) {
         training_set[tr_pos] = new Card();
         training_set[tr_pos].imageLoad(images, 16 + i * 196);
         training_set[tr_pos].labelLoad(labels, 8 + i);
         tr_pos++;
      }
      else {
         testing_set[te_pos] = new Card();
         testing_set[te_pos].imageLoad(images, 16 + i * 196);
         testing_set[te_pos].labelLoad(labels, 8 + i);
         te_pos++;
      }
     
   }
  
}
