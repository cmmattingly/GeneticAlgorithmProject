class Goal{
  PVector pos;
  
  Goal(int x, int y){
    pos = new PVector(x,y);
  }
  
  void display(){
    fill(255,0,0);
    ellipse(pos.x, pos.y, 10, 10);
  }
}
