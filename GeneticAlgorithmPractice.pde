Population pop;
Goal exit;

void setup(){
  size(800,800);
  pop = new Population(400);
  exit = new Goal(400,10);
}

void draw(){
  background(255);
  exit.display();
  if(pop.popDead()){
    pop.calcFitness();
    pop.nSelection();
    pop.mutate();
  } else{
    pop.update();
    pop.display();
  }
  
}
