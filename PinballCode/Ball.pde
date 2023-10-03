ArrayList<Vec2> balls = new ArrayList<Vec2>();
ArrayList<Vec2> velocities = new ArrayList<Vec2>();
int max = 3;


void newBalls() {
  if (balls.size() < max) {
    Vec2 pos = new Vec2(random(width), 0);
    Vec2 v = new Vec2(0, 400);
    
    balls.add(pos);
    velocities.add(v);
  }
}

void updateBalls() {
 for (int i = 0; i < balls.size(); i++) {
   update(1/(frameRate), balls.get(i), velocities.get(i));
   for(int j = 0; j <balls.size(); j++) {
     if (j!= i) {
       detect.BallBall(balls.get(i), r, velocities.get(i), balls.get(j), velocities.get(j), rest );
     }
   }
 }
}
