PImage backgroundImage;
boolean imBG = false;
int bgc, st1, st2, st3, f1, f2, f3;

public void File() {
//read background file
    
    String filename = "turtle.txt";
    String [] s = loadStrings(filename);
    //println(lines[0]);
    String type = null;
    for (int i = 0; i < s.length; i++) {
      //determines object type
      if (s[i].startsWith("Background")) {
        println("bg");
        String [] bg = splitTokens(s[i], ":");
        //println(bg[0]);
        //println(bg[1]);
        if(bg[1].equals("None")){
          //println(bg[2]);
          bgc = int(bg[2]);
        }
        else {
          backgroundImage = loadImage(bg[2]);
        }
        //stroke color
        st1 = int(bg[3]);
        st2 = int(bg[4]);
        st3 = int(bg[5]);
        //fill color
        f1 = int(bg[6]);
        f2 = int(bg[7]);
        f3 = int(bg[8]);
        
      }
      else if (s[i].startsWith("Box")) {
         type = "Box";
      }
      else if (s[i].startsWith("Curve")) {
         type = "Curve";
      }
      else if (s[i].startsWith("Circle")) {
         type = "Circle";
      }
      else if (s[i].startsWith("Line")) {
         type = "Line";
      }
      
      else{
        String [] data = splitTokens(s[i], ",");
        if (type == "Box") {
          b.add(new Box(float(data[0]), float(data[1]), float(data[2]), float(data[3])));
        }
        if (type == "Curve") {  //first l index is curve
          l.add(new Line(float(data[0]), float(data[1]), float(data[2]), float(data[3])));
        }
        if (type == "Circle") {
          c.add(new Circle(float(data[0]), float(data[1]), (float(data[2]))/2));
        }
        if (type == "Line") {
          l.add(new Line(float(data[0]), float(data[1]), float(data[2]), float(data[3])));
        }
      }
    }
}
      
