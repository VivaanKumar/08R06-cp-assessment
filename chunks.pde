//each chunk will be 600px by 600px as 8x8 grid, each box is 75px x 75px 

char[][][] randomChunks = {
  
  
  {
        {'-', ' ', '-', ' ', ' ', ' ', '-', '-'},
        {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', '-', ' ', ' ', ' ', ' '},
        {' ', '-', ' ', ' ', ' ', '-', ' ', ' '},
        {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {'m', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
  },
  
  {
        {'-', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', '-', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' ', ' ', '-', ' ', '-'},
        {' ', ' ', 'm', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', '-', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '},
        {' ', ' ', ' ', ' ', '-', ' ', ' ', ' '},
  },
 

  
};

void addChunks () {
  char[][] randomChunk = randomChunks[int(random(randomChunks.length))];
  
  print(int(random(randomChunks.length)));
  
  for(int j = 0; j < randomChunk.length; j++) {
      for(int i = 0; i < randomChunk[j].length; i++) {
        char type = randomChunk[j][i];
        
        if(type == '-') {
          float randomSize = 55 + random(20);
          //image(rock, i * 75 + (75-randomSize)/2, j * 75, 60, 60);
          //visibleObstacles[visibleObstacles.length] = new Obstacle();
          
          
          visibleObstacles.add( new Obstacle('-', j, i));
          
          
          //visibleObstacles = append(visibleObstacles, new Obstacle());
        }
        
        if(type == 'm') {
          visibleObstacles.add( new Obstacle('m', j, i));
        }
        
        if(type == ' ') {
          //add the gold coins
          if(random(1) < 0.03) {
            //random 10 perc chance
            visibleObstacles.add( new Obstacle('c', j, i));
          }
        }
        
        if(type == ' ') {
          //add the lives
          if(random(1) < 0.005) {
            //random 10 perc chance
            visibleObstacles.add( new Obstacle('l', j, i));
          }
        }
      }
    };
    //addChunks();
}
