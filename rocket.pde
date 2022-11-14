

import processing.sound.*;

SoundFile fly;
Rocket rocket;

float y_scroll;

//movement vars
boolean wKey;
boolean aKey;
boolean dKey;

PFont font;

PImage rocket_body;
PImage rocket_fire;
PImage rock;
PImage coin;
PImage lives_body;
PImage monster;
boolean gameOver;

int collectedCoins = 0;
int lives = 3;

//char[][] visibleChunks;
ArrayList<Obstacle> visibleObstacles = new ArrayList<Obstacle>();

void setup () {
  rocket = new Rocket();
  size(600, 900);
  rocket_body = loadImage("plane_body.png");
  rocket_fire = loadImage("plane_fire.png");
  monster = loadImage("monster.png");
  rock = loadImage("rock.png");
  coin = loadImage("coin.png");
  lives_body = loadImage("lives.png");
  font = loadFont("AgencyFB-Bold-48.vlw");
  //fly = new SoundFile(this, "fly.mp3");
  //fly.play();
  rectMode(CENTER);
  
  addChunks();
  
  surface.setTitle("Turbo Flight");
 
  
}

void draw () {
  background(42, 55, 64);
  
  if(lives <= 0 && gameOver == false) gameOver = true;
  
  if(gameOver) tint(100, 100, 100);
  
    //background(10, 10, 50;
  
  pushMatrix();
  translate(0, y_scroll);

  
    
  for(int i = 0; i < visibleObstacles.size(); i++){
    visibleObstacles.get(i).update();
  }
    rocket.update();
  
  
    
  rectMode(CORNER);
  popMatrix();
 
  
  if(!gameOver) {
      y_scroll += 3;
  textFont(font, 30);
  image(coin, 20, height-85, 50, 50);
  text(collectedCoins, 80,height - 50);
  
  if (lives >= 1) image(lives_body, 20, height- 150, 50, 50);
  if (lives >= 2) image(lives_body, 80, height- 150, 50, 50);
  if (lives >= 3) image(lives_body, 140, height- 150, 50, 50);
  
  text("Distance: " + int(abs((rocket.position.y - 350)/10)) + " m", 20, height- 180);
  }
  
  if(gameOver) {
  wKey = false;
  aKey = false;
  dKey = false;
  rocket.velX = 0;
  rocket.velY = 0;
}

textSize(120);
  if(gameOver) {
    text("You lose!", width/2 - 210, height/2);
    textSize(50);
    text("Hit 'space' to retry", width/2 - 200, height/2 + 100);
    textSize(30);
    text("Distance: " + int(abs((rocket.position.y - 350)/10)) + " m", width/2 - 200, height/2 + 150);
    text("Coins: " + collectedCoins +  " (" + int(collectedCoins* 20) + " " + "m extra" + ")", width/2 - 200, height/2 + 200);
    text("Score: " + int(int(abs((rocket.position.y - 350)/10)) + int(collectedCoins* 20)),  width/2 - 200, height/2 + 250);
    
  }

  
}

class Rocket {
  int size = 50; //w and h both
  PVector position = new PVector(300 - size/2, 350);
  float angle = 90;
  int flying = 0;
  //0 and 255 toggle for smooth animation
  
  float velX = 0;
  float velY = 0;
  
  float maxSpeed = 5;
  
  float friction = 0.98;
  
  
  void update () {
    
    if(aKey) {
      angle -= 2;
    }
    
    if(dKey) {
      angle += 2;
      
    }
    
    if(velY < -maxSpeed) {
      velY = -maxSpeed;
    }
    
    if(velY > maxSpeed) {
      velY = maxSpeed;
    }
    
    if(velX < -maxSpeed) {
      velX = -maxSpeed;
    }
    
    if(velX > maxSpeed) {
      velX = maxSpeed;
    }
    
    
    
    velX *= friction;
    velY *= friction;
    
    position.x += velX;
    position.y += velY;
    
        if(wKey) {
          if(position.y + y_scroll < height/2 - size/2 - 100){
        //position.y -= sin(radians(angle)) * 1.5;
        position.x -= cos(radians(angle)) * 3;
        position.y = height/2 - size/2 - 100 - y_scroll;
        //velX = 0;
        //velY = 0;
      } else {
        velY -= sin(radians(angle)) * 3;
        velX -= cos(radians(angle)) * 3;
      } 
        //fly.play();
      
      if(flying != 255) flying += 20;
     
     
    } else flying = 0;
    
    //boundaries
    
    if(position.x < size/2) {
      position.x = size/2;
    }
    if(position.x > width - size/2) {
      position.x = width - size/2;
    }
    
    
   
    
    
    pushMatrix();
    
    translate(position.x, position.y);
    rotate(radians(angle - 90));
    image(rocket_body, -size/2, -size/2, size, size);
    tint(255, flying);
    image(rocket_fire, -size/6, size/2.5, size/3, size/3);
    noTint();
   
    
    popMatrix();
    
  }
}

void keyPressed () {
   if(key == ' ' && gameOver) {
    resetAll();
  }
  
  if(gameOver) return;
  
  
  if(keyCode == UP) {
    wKey = true;
    
  }
  if(keyCode == LEFT) {
    aKey = true;
    dKey = false;
  }
  if(keyCode == RIGHT) {
    dKey = true;
    aKey = false;
  }
  
}

void keyReleased () {
  if(gameOver) return;
  
  if(keyCode == UP) {
    wKey = false;
  }
  if(keyCode == LEFT) {
    aKey = false;
  }
  if(keyCode == RIGHT) {
    dKey = false;
  }
}

void resetAll() {
  lives = 3;
  collectedCoins = 0;
  gameOver = false;
  y_scroll = 0;
  rocket.position = new PVector(300 - rocket.size/2, 350);
  rocket.angle = 90;
  rocket.flying = 0;
  //0 and 255 toggle for smooth animation
  
  rocket.velX = 0;
  rocket.velY = 0;
  visibleObstacles = new ArrayList<Obstacle>();
  setup();
}
