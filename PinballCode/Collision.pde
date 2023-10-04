 public class CollisionDetection {
  
   //taken from Dr. Guy and slightly modified
    void BallFlipper(Vec2 ball, float r, Vec2 vel, float rest, Flipper f) {
    //   float restitution = 0.8;
      Vec2 flipper_base = f.flipper_base;
    
      // Find the closest point on the line segment
      Vec2 tip = getTip(f);
      Vec2 dir = tip.minus(flipper_base);
      Vec2 dir_norm = dir.normalized();
      float proj = dot(ball.minus(flipper_base), dir_norm);
      Vec2 closest;
      if (proj < 0) {
        closest = flipper_base;
      } 
      else if (proj > dir.length()) {
        closest = tip;
      } 
      else {
        closest = flipper_base.plus(dir_norm.times(proj));
      }
  
    // Check if the ball is close enough to the line segment
      dir = ball.minus(closest);
      float dist = dir.length();
      if (dist > r) {
        return;
      }
      dir.mul(1.0/dist); // Normalize dir
  
    // Move the ball outside the line segment
      ball = closest.plus(dir.times(r));
  
    // Velocity of the flipper at the point of contact
      Vec2 radius = closest.minus(flipper_base);
      Vec2 surfaceVel = new Vec2(0,0);
      if (radius.length() > 0) {
        surfaceVel = (new Vec2(-radius.y, radius.x)).normalized().times(f.angular_velocity * radius.length());
    }
    // Calculate the new ball velocity
    float v_ball = dot(vel,dir);
    float v_flip = dot(surfaceVel,dir);
    float m1 = 1;
    float m2 = 10; // Give the flipper a big mass compared to the ball [TODO: Should be infinite ... you should update it!]
  
    // Conservation of momentum
    float new_v = (m1 * v_ball + m2 * v_flip - m2 * (v_ball - v_flip) * rest) / (m1 + m2);
  
    vel.add(dir.times(new_v - v_ball));
}
   //end
   
   
   
   void CircleBox(Vec2 ball, float r, Vec2 vel, Box b, float rest) { //Circle-Box collision
    CircleLine(ball, r, vel, b.l1, rest);
    CircleLine(ball, r, vel, b.l2, rest);
    CircleLine(ball, r, vel, b.l3, rest);
    CircleLine(ball, r, vel, b.l4, rest);
   }
  
  
   void CircleCircle(Vec2 ball, float r, Vec2 vel, Circle circ, float rest) { //Circle-Circle collision
    //check to see if ball and circle are overlapping
    //Vec2 dir = ball.minus(circ.pos);
    float dist = ball.distanceTo(circ.pos);
    //Vec2 dir_norm = dir.normalized();
    
     if (dist < (r  + circ.r)) {  //collision
     //println(dist, (r+circ.r));
     Vec2 dir = ball.minus(circ.pos);
     Vec2 dir_norm = dir.normalized();
     
     ball = circ.pos.plus(dir_norm.times(circ.r+ r));
     vel.mul(-1*rest); 
     newBalls();
     }
   }
   
   void BallBall(Vec2 ball1, float r, Vec2 vel1, Vec2 ball2, Vec2 vel2, float rest) { //Circle-Circle collision
    //check to see if ball and circle are overlapping
    //Vec2 dir = ball2.minus(ball1);
    float dist = ball1.distanceTo(ball2);
    //Vec2 dir_norm = dir.normalized();
    
     if (dist < (r + r)) {  //collision
     //println(dist, (r+circ.r));
     float overlap = (2 * r - dist)/2;
     
     //ball1.subtract(dir.times(overlap));
     //ball2.add(dir.times(overlap));
     Vec2 dir = ball1.minus(ball2);
     Vec2 dir_norm = dir.normalized();
     
     ball1 = ball1.plus(dir_norm.times(overlap));
     ball2 = ball2.plus(dir_norm.times(overlap));
     vel1.mul(-1*rest); 
     vel2.mul(-1*rest); 
     //newBalls();
     }
   }
  
  //code based on Prof's sent in slack
   void CircleLine(Vec2 circ, float r, Vec2 vel, Line l, float rest) { //Line-Circle collision
    Vec2 dir = l.l2.minus(l.l1);
    Vec2 dir_norm = dir.normalized();
    Vec2 closest;
    float proj = dot(circ.minus(l.l1), dir_norm);
    //Vec2 tolerance = new Vec2 (5, 5);
    
    if (proj < 0) {
     closest = l.l1;
    }
    else if (proj > dir.length()) {
     closest = l.l2; 
    }
    else {
     closest = l.l1.plus(dir_norm.times(proj)); 
    }
    
    dir = circ.minus(closest);
    float dist = dir.length();
    
    if (dist > r ) return;
    
    dir.mul(1/dist);
    
    circ = closest.plus(dir.times(r));  //.5 is for tolerance
    
    vel.subtract(dir.times(rest*2*dot(vel, dir)));
    
    if (!cCollide && l == curve) { 
      cCollide = true;
      l.l1.set(new Vec2 (launch.x, launch.y));
     }

   }
  

  
 //  boolean SameSide(Line line1, Line line2) {
 //   float cp1 = cross(line2.l1.minus(line1.l1), line1.l2.minus(line1.l1));
 //   float cp2 = cross(line2.l2.minus(line1.l1), line1.l2.minus(line1.l1)); 
 //   return cp1*cp2 >= 0;
 //  }
 }  
  

 //public class Object {
 //}

 public class Box  {
  float x, y, width, height;
//   int id;
  Vec2 pos;
  Line l1, l2, l3, l4;
 
  Box(float x, float y, float width, float height) { //x,y are left upper corner
   this.x = x;
   this.y = y;
   this.width = width;
   this.height = height;
   this.pos = new Vec2(x, y);
   this.l1 = new Line( x, y, x, y+(height));  //quadrent 1
   this.l2 = new Line( x, y, x+(width), y);  //quadrent 2
   this.l3 = new Line( x+(width), y, x+(width), y+(height));  //quadrent 3
   this.l4 = new Line( x, y+(height), x+(width), y+(height));  //quadrent 4
  }
 }

 public class Circle {
  float x, y, r;
//   int id;
  Vec2 pos;
 
  Circle (float x, float y, float r) {
   this.x = x;
   this.y = y;
   this.r = r;
   this.pos = new Vec2 (x, y);
  }
 }

 public class Line {
  float x1, y1, x2, y2;
//   int id;
  Vec2 l1, l2;
 
  Line (float x1, float y1, float x2, float y2) {
    this.x1 = x1;
    this.y1= y1;
    this.x2 = x2;
    this.y2 = y2;
    this.l1 = new Vec2(x1, y1);
    this.l2 = new Vec2(x2, y2);
  }
 }
 
 //object with features defined by Dr. Guy
 public class Flipper {
    float min_angle, max_angle, angle, line_length, angular_velocity;
    Vec2 flipper_base;

    Flipper(Vec2 flipper_base, float min_angle,
    float max_angle, float line_length, float angular_velocity) {
        this.flipper_base = flipper_base;
        this.min_angle = min_angle;
        this.max_angle = max_angle;
        this.angle = max_angle;
        this.line_length = line_length;
        this.angular_velocity = angular_velocity;
    }
 }
 
 
