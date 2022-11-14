class Obstacle {
  char type;
  int myI;
  int myJ;
  float randomSize = 60;
  float randomAngle =0;
  
  float x = 0;
  float y = 0 - y_scroll - 600;
  boolean nextBatchComplete = false;
  
  float monsterSinDance = 0;
  int monsterDir = 0;
 
  
  Obstacle (char givenType,int j, int i) {
   type = givenType;
   myI = i;
   myJ = j;
   
   //println(random(1));
  if(random(1) < 0.5) {
    monsterDir = -1;
    //println("wil be nag");
  } else {
    monsterDir = 1;
  }
  }
  
  boolean checkCollisions () {
    //println(rocket.position.x, rocket.position.y, myI * 75, myJ * 75 + y);
    float obstacle_x1 =  myI * 75 + x;
    float obstacle_y1 = myJ * 75 + y;
    float obstacle_x2 =  myI * 75 + 75 + x;
    float obstacle_y2 = myJ * 75 + y + 75;
    
    float rocket_x1 = rocket.position.x;
    float rocket_y1 = rocket.position.y;
    float rocket_x2 = rocket.position.x + rocket.size;
    float rocket_y2 = rocket.position.y + rocket.size;
    
    if (obstacle_x1 > rocket_x2 || rocket_x1 > obstacle_x2) return false;

  // has vertical gap
    if (obstacle_y1 > rocket_y2 || rocket_y1 > obstacle_y2) return false;
    
    return true;    
  }
  
  void update () {
    
    if(type == 'm') {
      monsterSinDance += 3;
      y += sin(radians(monsterSinDance)) * 2;
      x += monsterDir;
      
      if(x + (myI * 75) <= 0) {
        monsterDir = 1;
      }
      
      if(x + (myI * 75) + 75 > width) {
        monsterDir = -1;
      }
      
      println(x);
    }
    
    if(checkCollisions()) {
      if(type == 'c') {
        collectedCoins++;
      }
      
      if(type == '-') {
        lives--;
      }
      
      if(type == 'l') {
        lives++;
      }
      removeObstacle(this);
    }
    
    if(type == '-') {
      pushMatrix();
      translate(myI * 75, myJ * 75 + y);
      rotate(radians(randomAngle));
      image(rock, 0, 0, randomSize, randomSize);
      //rect(0, 0, randomSize, randomSize);
      //rect(0, 0, 75, 75); hitbox
      popMatrix();
    }
    
    if(type == 'c') {
      pushMatrix();
      translate(myI * 75 , myJ * 75 + y);
      //rotate(radians(randomAngle));
      //rect(0, 0, 75, 75); hitbox;
      image(coin, 0, 0, randomSize, randomSize);
      popMatrix();
    }
    
    if(type == 'm') {
      pushMatrix();
      translate(myI * 75 + x, myJ * 75 + y);
      //rotate(radians(randomAngle));
      //rect(0, 0, 75, 75); hitbox;
      image(monster, 0, 0, 75, 75);
      popMatrix();
    }
    
    if(type == 'l') {
      pushMatrix();
      translate(myI * 75 + (75-randomSize)/2 + x, myJ * 75 + y);
      //rotate(radians(randomAngle));
      //rect(0, 0, 75, 75); hitbox;
      image(lives_body, 0, 0, randomSize, randomSize);
      popMatrix();
    }
    
    if(myJ == 0 && myI == 0 && y > -y_scroll && !nextBatchComplete){
      addChunks();
      nextBatchComplete = true;
    }
    
    if(y + y_scroll> 900) {
      removeObstacle(this);
    }
  }
}



void removeObstacle (Obstacle elementToRemove) {
  int[] toDelete = {};
  
  for(int i = 0; i < visibleObstacles.size(); i++) {
    if(visibleObstacles.get(i) == elementToRemove) {
      toDelete = append(toDelete, i);
    }
  }
  
  for(int i = 0; i < toDelete.length; i++) {
    //println(toDelete[i]);
    //visibleObstacles[toDelete[i]] = {};
    visibleObstacles.remove(toDelete[i]);
  }
}
