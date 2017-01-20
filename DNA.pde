class DNA {

  ArrayList<Character> genes;
  float geneLength;
  float fitness;
  float AFN;
  String alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ .[],'`()^%&*$#@!";

  DNA(float geneLength_) {

    genes = new ArrayList<Character>();
    geneLength = geneLength_;
    fitness = 0;
    AFN = 0;


    while (genes.size() < geneLength) {
      genes.add(alphabet.charAt(int(random(69))));
    }
  }

  DNA commute(DNA d2) {
    ArrayList<Character> a = new ArrayList<Character>(genes);
    ArrayList<Character> b = new ArrayList<Character>(d2.genes);
    ArrayList<Character> n = new ArrayList<Character>();

    int len = int(geneLength / 2);

    for (int i = 0; i < geneLength; i++) {
      if (i < len ) {
        n.add(a.get(i));
      } else {
        n.add(b.get(i));
      }
    }

    DNA dna = new DNA(geneLength);
    dna.genes = new ArrayList<Character>(n);
    return dna;
  }

  void mutate(float chance) {
    for (int i = 0; i < genes.size(); i++) {
      if (random(100) <= chance) {
        genes.set(i, alphabet.charAt(int(random(69))));
      }
    }
  }
}