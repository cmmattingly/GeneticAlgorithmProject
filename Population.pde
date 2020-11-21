class Population{
  Dot[] dots;
  float fitnessSum;
  int gen = 0;
  
  int bestDotIndex = 0; //so that the best dots dont mutate
  int minStep = 400;
  
  Population(int size){
    dots = new Dot[size]; 
    for(int i = 0; i < dots.length; i++){
      dots[i] = new Dot();
    } 
  }
  
  void display(){
    for(Dot dot: dots){
      dot.display();
    }
    dots[0].display();
  }
  
  void update(){
    for(Dot dot: dots){
      if(dot.brain.step > minStep){
        dot.dead = true;
      } else{
        dot.update();
      }
    }
  }
  
  void calcFitness(){
    for(Dot dot: dots){
     dot.calcFitness(); 
    }
  }
  
  boolean popDead(){
    for(Dot dot: dots){
      if(!dot.dead && !dot.goalReached){
        return false;
      }
    }
    return true;
  }
   
  void nSelection(){
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calcFitnessSum();
    
    newDots[0] = dots[bestDotIndex].selectBaby();
    newDots[0].isBest = true;
    
    for(int i = 1; i < dots.length; i++){
      Dot parent = selectParent();
      
      newDots[i] = parent.selectBaby() ;
    }
    
    dots = newDots.clone();
    gen++; 
    
  }
  
  void calcFitnessSum(){
     fitnessSum = 0;
     
     for(Dot dot: dots){
       fitnessSum += dot.fitness;
     }
  }
  
  Dot selectParent(){
    float rand = random(fitnessSum);
     
     float runningSum = 0;
     for(Dot dot: dots){
       runningSum += dot.fitness;
       if(runningSum > rand){
         return dot;
       }
     }
     return null;
  }
  
  void mutate(){
    for(int i = 1; i < dots.length; i++){
      dots[i].brain.mutate();
    }
  }
  
  void setBestDot(){
    float max = 0;
    int maxIndex = 0;
    
    for(int i = 0; i < dots.length; i++){
      if(dots[i].fitness > max){
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    
    bestDotIndex = maxIndex;
    
    if(dots[bestDotIndex].goalReached){
      minStep = dots[bestDotIndex].brain.step;
    }
  }
}
