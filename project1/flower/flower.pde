ArrayList<Flower> flowers = new ArrayList<Flower>();

void setup() {
  size(800, 600);
  background(255);
}

void draw() {
  for (Flower flower : flowers) {
    flower.display();
  }
}

void mouseClicked() {
  // Create a new flower with a random color at the mouse click position
  color randomColor = color(random(255), random(255), random(255));
  Flower newFlower = new Flower(mouseX, mouseY, randomColor);
  flowers.add(newFlower);
}

class Flower {
  float x, y;
  color flowerColor;

  Flower(float x, float y, color flowerColor) {
    this.x = x;
    this.y = y;
    this.flowerColor = flowerColor;
  }

  void display() {
    // Flower petals
    pushMatrix();
    translate(x, y);
    for (int i = 0; i < 10; i++) {
      rotate(PI / 2);
      fill(flowerColor);
      ellipse(95, 0, 150, 100); 
      strokeWeight(2);
      stroke(255,255);
    }
    fill(252, 244, 194);
    ellipse(0, 0, 80, 80);
    popMatrix();
  }
}
