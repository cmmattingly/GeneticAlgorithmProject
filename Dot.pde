 class Dot{
   PVector pos;
   PVector vel;
   PVector acc;
   Brain brain; 
   
   boolean isBest = false;
   boolean dead = false; 
   boolean goalReached = false; 
   float fitness = 0;
   
   
   Dot(){
     brain = new Brain(1000);
     pos = new PVector(width/2, height - 15);
     vel = new PVector(0,0);
     acc = new PVector(0,0);
   }
   
   void display(){
     if(isBest == true){
       fill(0,255,0);
       ellipse(pos.x, pos.y, 6, 6);
     } else {
       fill(0);
       ellipse(pos.x, pos.y, 4, 4); //x,y, width, height
     }
   }
   
   void move(){
     if(brain.directions.length > brain.step){
       acc = brain.directions[brain.step];
       brain.step++; 
     } else{
       dead = true;
     }
     vel.add(acc);
     vel.limit(5);
     pos.add(vel);
   } 
   
   void update(){
     if(!dead && !goalReached){
       move();
       if(pos.x < 2 || pos.y < 2 || pos.x > width - 2 || pos.y > height - 2){
         dead = true; 
       } else if(dist(pos.x, pos.y, exit.pos.x, exit.pos.y) < 5){
         goalReached = true;
       }
     }
   } 
   
   void calcFitness(){
     if(goalReached){
       fitness = 1.0/16.0 + 10000.0/(float)(brain.step * brain.step);
     } else{
       float distanceToGoal = dist(pos.x, pos.y, exit.pos.x, exit.pos.y);
       fitness = 1/(distanceToGoal * distanceToGoal);
     }
   }
    
   Dot selectBaby(){
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby; 
  }
 }
