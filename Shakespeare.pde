Pop popu;
int generations = 0;
String phrase = "To be or not to be.";


void setup() {
  size(750, 230);
  popu = new Pop(200, 1, phrase);
}

void draw() {
  generations += 1;
  background(127);
  popu.evaluateFitness();
  popu.buildGenePool();
  popu.breed();
  popu.evaluateFitness();
  ArrayList m = popu.maxFitness().genes;
  String best = thingstring(m);
  textSize(30);
  text(best, 30, 60);
  textSize(24);
  text("Max Fitness:", 30, 120);
  text(popu.mF.fitness, 230, 120);
  text("Average Fitness:", 30, 150);
  text(popu.avgFitness(), 230, 150);
  text("generation:", 30, 180);
  text(Integer.toString(generations), 238, 180);
  if (popu.mF.fitness == 100) {
   noLoop(); 
  }
}

String thingstring(ArrayList<Character> chars) {
  StringBuilder result = new StringBuilder(chars.size());
  for (Character c : chars) {
    result.append(c);
  }
  String output = result.toString();
  return output;
}