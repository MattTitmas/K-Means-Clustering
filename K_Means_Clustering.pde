PVector[] Clusters;
PVector[] pointPositions;
int numberOfPoints = 100;
int numberOfClusters = 3;
int ColourDiff;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  pointPositions = new PVector[numberOfPoints];
  ColourDiff = int(255/numberOfClusters);
  Clusters = new PVector[numberOfClusters];
  generatePoints();
  for (int i = 0; i < numberOfClusters; i++) {
    Clusters[i] = new PVector(random(10, width-10), random(10, height-10));
  }
}

void draw() {
  if (frameCount % 60 == 0) {
    move();
  }
  background(360, 0, 100);
  for (int i = 0; i < numberOfPoints; i++) {
    float dist = 10000;
    color fillColour = color(0, 0, 0);
    for (int j = 0; j < numberOfClusters; j++) {
      float newDist = dist(Clusters[j].x, Clusters[j].y, pointPositions[i].x, pointPositions[i].y);
      if (newDist < dist) {
        fillColour = color(360*(ColourDiff*j)/255, 100, 100);
        dist = newDist;
      }
    }
    strokeWeight(0);
    fill(fillColour);
    stroke(fillColour);
    ellipse(pointPositions[i].x, pointPositions[i].y, 15, 15);
  }
  for (int i = 0; i < numberOfClusters; i++) {
    fill(360*(ColourDiff*i)/255, 100, 100);
    stroke(0);
    strokeWeight(5);
    ellipse(Clusters[i].x, Clusters[i].y, 15, 15);
  }
}

void keyPressed() {
  if (key == ' ') {
    frameCount = 0;
    setup();
  }
}

void move() {
  PVector[] NewPos = new PVector[numberOfClusters];
  for (int i = 0; i < numberOfClusters; i++) {
    NewPos[i] = new PVector(0, 0);
  }
  int[] Amount = new int[numberOfClusters];
  for (int i = 0; i < numberOfPoints; i++) {
    int Smallest = 0;
    float Distance = 10000;
    for (int j = 0; j < numberOfClusters; j++) {
      if (dist(Clusters[j].x, Clusters[j].y, pointPositions[i].x, pointPositions[i].y) < Distance) {
        Distance = dist(Clusters[j].x, Clusters[j].y, pointPositions[i].x, pointPositions[i].y);
        Smallest = j;
      }
    } 
    NewPos[Smallest].add(pointPositions[i]);
    Amount[Smallest] += 1;
  }
  for (int i = 0; i < numberOfClusters; i++) {
    NewPos[i].div(Amount[i]);
  }
  for (int i = 0; i < numberOfClusters; i++) {
    Clusters[i].x = NewPos[i].x;
    Clusters[i].y = NewPos[i].y;
  }
}

void generatePoints() {
  PVector[] clusterCentres = new PVector[numberOfClusters];
  for (int i = 0; i < numberOfClusters; i++) {
    clusterCentres[i] = new PVector(random(50, width-50), random(50, height-50));
  }

  for (int i = 0; i < numberOfPoints; i++) {
    int random = floor(random(0, numberOfClusters));
    pointPositions[i] = new PVector(clusterCentres[random].x + randomGaussian()*50, clusterCentres[random].x + randomGaussian()*50);
  }
}
