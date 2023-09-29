import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer player; 
FFT fft;
ArrayList<Organic> organics;
boolean generateShapes = true;
color[] colorPalette;

void setup() {
  size(800, 800);
  background(0, 255);
  colorMode(RGB, 255, 255, 255, 100); // Enable alpha for transparency
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

  minim = new Minim(this);
  player = minim.loadFile("music1.mov"); // Sound input
  player.play();
  
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.linAverages(16);

  organics = new ArrayList<Organic>();

  for (int i = 0; i < 110; i++) {
    organics.add(new Organic(0.1 + i, width / 2, height / 2, i * 1, i * random(90), colorPalette[(int) random(8)]));
  }
}

void draw() {
  background(43, 44, 52);

  if (generateShapes) {
    fft.forward(player.mix);
    
    for (int i = 0; i < organics.size(); i++) {
      float amplitude = fft.getBand(i) * 15; // Adjust the multiplier to control scaling
      organics.get(i).show(amplitude);
    }
  }
}

//void keyPressed() {
//  if (key == ' ') {
//    generateShapes = !generateShapes; // Toggle the generation of shapes on/off
//  }
//}

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

  void show(float scale) {
    noStroke();
    fill(this.color1);
    pushMatrix();
    translate(xpos, ypos);
    rotate(angle);
    scale(scale); // Scale the shape based on amplitude
    beginShape();
    float off = 0;
    for (float i = 0; i < TWO_PI; i += 0.1) {
      float offset = map(noise(off), 0, 1, -roughness, roughness);
      float r = radius + offset;
      float x = r * cos(i);
      float y = r * sin(i);
      vertex(x, y);
      off += 0.1;
    }
    endShape(CLOSE); // Close the shape to fill it
    popMatrix();
  }
}
