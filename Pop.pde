class Pop {

  ArrayList<DNA> population;
  ArrayList<DNA> genepool;
  String goal;
  float maxpop;
  float mutationRate;
  float geneLength;
  DNA mF;

  Pop(float size, float mutationRate_, String goal_) {

    population = new ArrayList<DNA>();
    genepool = new ArrayList<DNA>();
    goal = goal_;
    geneLength = goal.length();
    maxpop = size;
    mutationRate = mutationRate_;


    while (population.size() < maxpop) {
      DNA dna = new DNA(geneLength);
      population.add(dna);
    }
  }

  void evaluateFitness() {
    float mx = goal.length();
    float amF = 0;
    for (DNA d : population) {
      d.fitness = 0;
      float acc = 0;
      for (int i = 0; i < goal.length(); i++) {
        if (goal.charAt(i) == d.genes.get(i)) {
          acc += 1;
        }
      }
      d.fitness = 100 * acc/mx;
      d.fitness = map(d.fitness, 0, 100, 0, 10);
      d.fitness = pow(2, d.fitness);
      d.fitness = map(d.fitness, 0, pow(2, 10), 0, 100);
      if ( d.fitness > amF ) {
        amF = d.fitness;
        mF = d;
      }
    }
  }

  //void buildGenePool() {
  //  DNA chosen = new DNA(geneLength);;
  //  genepool = new ArrayList<DNA>();
  //  float max = summedFitness();
  //  for (DNA d : population) {
  //    d.fitness /= max;
  //  }
  //  for (DNA d : population) {
  //    d.AFN = 0;
  //    for (DNA a : population) {
  //      if ( d.fitness > a.fitness ) {
  //        d.AFN += a.fitness;
  //      }
  //    }
  //  }
  //  float r = random(1);
  //  float min = 1;
  //  for (DNA d : population) {
  //   if (d.AFN < min ) {
  //    min = d.AFN;
  //    chosen = d;
  //   }
  //  }
  //}

  void buildGenePool() {
    genepool = new ArrayList<DNA>();
    float r = sqrt(random(mF.fitness * mF.fitness));
    for (DNA d : population) {
      if (d.fitness >  r) {
        genepool.add(d);
      }
    }
  }

  void breed() {
    ArrayList<DNA> newPop = new ArrayList<DNA>();
    while (newPop.size() < maxpop ) {
      DNA a = genepool.get(int(random(genepool.size())));
      DNA b = genepool.get(int(random(genepool.size())));
      DNA dna = a.commute(b);
      dna.mutate(mutationRate);
      newPop.add(dna);
    }
    population = new ArrayList<DNA>(newPop);
  }

  DNA maxFitness() {
    float max = 0;
    DNA current = population.get(0);
    for (DNA dna : population) {
      if (dna.fitness > max) {
        max = dna.fitness;
        current = dna;
      }
    }
    return current;
  }

  float avgFitness() {
    float acc = 0;
    for (DNA d : population) {
      acc += d.fitness;
    }
    acc /= population.size();
    return acc;
  }

  float summedFitness() {
    float acc = 0;
    for (DNA d : population) {
      acc += d.fitness;
    }
    return acc;
  }
}