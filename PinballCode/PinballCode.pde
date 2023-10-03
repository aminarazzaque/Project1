/*
Name: Amina Razzaque
user: razza025
Student ID: 5630120
*/

//Initializing variables
CollisionDetection detect = new CollisionDetection();
//ball vars
float d = 20;
float r = d*.5;
float rest = 0.98;
//boolean launch = true;
Vec2 velStart;
Vec2 ballStart;

//flags
boolean cCollide;
boolean paused;
boolean left;
boolean right;
boolean gameOver;

//obstacle arraylists
ArrayList<Box> b = new ArrayList<Box>();
ArrayList<Line> l = new ArrayList<Line>();
ArrayList<Circle> c = new ArrayList<Circle>();

//special cases
Box launch; //stan
Line curve;
Flipper flipper1;
Flipper flipper2;
//Circle c1;

//flipper trial
// Line segment
// Vec2 flipper_base = new Vec2(50,550);
// float min_angle = -0.6;
// float max_angle = 0.9;
// float angle = max_angle;
// float line_length = 120;
// float angular_velocity = -2.0;

Vec2 getTip(Flipper f){
  // Compute tip as a function of angle and line_length
  Vec2 tip = new Vec2(0,0);
  tip.x = f.flipper_base.x + f.line_length*cos(f.angle);
  tip.y = f.flipper_base.y + f.line_length*sin(f.angle);
  return tip;
}

//flipper

//screen and ball set up
void setup () {
    size(400, 650);  //screen size
    
    //create ball
    ballStart = new Vec2(width-d, height-d);
    velStart = new Vec2(0,-400);

    //create flipper
    // Vec2 flipper_base = new Vec2(50,350);
    // float min_angle = -0.6;
    // float max_angle = 0.9;
    // float angle = max_angle;
    // float line_length = 120;
    // float angular_velocity = -2.0;
    
    flipper1 = new Flipper (new Vec2(50,550), -0.6, 0.9, 100, -2.0);
    flipper2 = new Flipper (new Vec2(350,550), -0.6, 0.9, -100, -2.0);
    File();
    
    curve = l.get(0);
    launch = b.get(0);
    cCollide  = false;
    paused = true;
    gameOver = false;
    
    balls.add(ballStart);
    velocities.add(velStart);
}

//flipper physics
void fPhysicsComp(float dt, Flipper f) {
    //flipper trial
    f.angle += f.angular_velocity*dt;
    if (f.angle > f.max_angle){
        f.angle = f.max_angle;
        f.angular_velocity *= -1;
    }
    if (f.angle < f.min_angle){
        f.angle = f.min_angle;
        f.angular_velocity *= -1;
    }
}
//done

//function to update ball physics
void physicsComp(float dt, Vec2 ball, Vec2 vel) {

     Vec2 acc = new Vec2(0, 45);
     vel.add(acc.times(dt));
     ball.add(vel.times(dt));
}

//function to update ball movement
void update(float dt, Vec2 ball, Vec2 vel) {
    
    physicsComp(dt, ball, vel); //updates ball position
    
    //move flippers if keys are pressed
    if (left) fPhysicsComp(dt, flipper1);
    if (right) fPhysicsComp(dt, flipper2);

   //adjusting to fit screen
    if (ball.y > height - r) {  //bottom of the screen 
        ball.y = height - r;
        gameOver = true;
    }
    if (ball.y < r){
      ball.y = r;
      vel.y *= -1;
    }
    if (ball.x > width - r){ 
      ball.x = width - r;
      vel.x *= -1;
    }
    if (ball.x < r){
      ball.x = r;
      vel.x *= -1;
    }
    
    //check line collisions
    for (int i = 0; i < l.size(); i++) {
      detect.CircleLine(ball, r, vel, l.get(i), rest);
    }
    for (int i = 0; i < b.size(); i++) {
      detect.CircleBox(ball, r, vel, b.get(i), rest);
    }
    for (int i = 0; i <c.size(); i++) {
      detect.CircleCircle(ball, r, vel, c.get(i), rest);
    }
    
    detect.BallFlipper(ball, r, vel, rest, flipper1);
    detect.BallFlipper(ball, r, vel, rest, flipper2);
    //println(l.get(0).x1);
}

//draw images

void draw() {
    //if (!paused) update(1/frameRate, ball, vel);
    if (!paused) updateBalls();
    
    if (gameOver) {
      background(255);
       fill(0);
       textSize(32);
       textAlign(CENTER, CENTER);
       text("Game Over", width / 2, height / 2);
    }
    else{
      if (bgc > 0) {
      background(bgc); //White background
      }
      else{
      image(backgroundImage, 0, 0, width, height);
      }
      
      //draw ball
      //stroke(0,0,0);
      //fill(10,120,10);
      stroke(st1, st2, st3);
      fill(f1, f2, f3);
      strokeWeight(2);

      //draw flipper1
      Vec2 tip1 = getTip(flipper1);
      line(flipper1.flipper_base.x, flipper1.flipper_base.y, tip1.x,tip1.y);
      //draw flipper 2
      Vec2 tip2 = getTip(flipper2);
      line(flipper2.flipper_base.x, flipper2.flipper_base.y, tip2.x,tip2.y);
      

      //circle(ballStart.x, ballStart.y, d);
      for (Vec2 ba: balls) {
       circle(ba.x, ba.y, d);
      }
      
      //moving curve
      //println(cCollide);
      if (cCollide) {
        line(launch.x,launch.y, l.get(0).x2, l.get(0).y2);
      }
      else {
        line(l.get(0).x1, l.get(0).y1, l.get(0).x2, l.get(0).y2);
      }
      
      //drawing obstacles
      for(Box box: b) {
        rect(box.x, box.y, box.width, box.height);
      }
      for(Circle circ: c) {
        circle(circ.x, circ.y, circ.r*2);
      }
    if (l.size() > 1) {  
    for(int i = 1; i < l.size(); i++) {
      line(l.get(i).x1, l.get(i).y1, l.get(i).x2, l.get(i).y2);
    } 
  }
    
    }
}

//launches the ball
void keyPressed() {
    if (key == ' ') paused = !paused;
    if (keyCode == LEFT) left = true;
    if (keyCode == RIGHT) right = true;
    
}

void keyReleased() {
   if (keyCode == LEFT) left = false;
    if (keyCode == RIGHT) right = false;
}
