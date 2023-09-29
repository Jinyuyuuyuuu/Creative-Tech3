ArrayList<Organic> organics = new ArrayList<Organic>();
float change;
color[] colorPalette;

void setup() {
  size(500, 500);
  background(0, 255);
  change = 0;
  colorPalette = new color[]{
    color(176,242,143,30),
    color(73, 127, 250, 30),
    color(198, 215, 250, 30),
    color(143, 44, 191, 30),
    color(245, 68, 133, 30),
    color(241, 116, 154, 30),
    color(247, 130, 152, 30),
    color(246, 156, 239, 30)
  };

  for (int i = 0; i < 110; i++) {
    organics.add(new Organic(0.1 + i, width/2, height/2, i * 1, i * random(90), colorPalette[(int)random(8)]));
  }
}

void draw() {
  background(43,44,52);
  for (int i = 0; i < organics.size(); i++) {
    organics.get(i).show(change);
  }
  change += 0.01;
}

class Organic {
  float radius, xpos, ypos, roughness, angle;
  color color1;
 
  Organic(float radius, float xpos, float ypos, float roughness, float angle, color color1) {
    this.radius = radius;
    this.xpos = xpos;
    this.ypos = ypos;
    this.roughness = roughness;
    this.angle = angle;
    this.color1 = color1;
  }

  void show(float change) {
    noStroke();
    fill(this.color1);
    pushMatrix();
    translate(xpos, ypos);
    rotate(angle + change);
    beginShape();
    float off = 0;
    for (float i = 0; i < TWO_PI; i += 0.1) {
      float offset = map(noise(off, change), 0, 1, -roughness, roughness);
      float r = radius + offset;
      float x = r * cos(i);
      float y = r * sin(i);
      vertex(x, y);
      off += 0.1;
    }
    endShape();
    popMatrix();
  }
}
