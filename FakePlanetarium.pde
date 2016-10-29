/* Fake Planetarium for Processing 2.x

   Yoshiki NAGATANI - Oct. 29th, 2016
     https://ultrasonics.jp/nagatani/
     https://twitter.com/nagataniyoshiki

  The program shows a full-screen fake planetarium using Processing 2.x software.
  The placement of the stars changes each time. You may find a lot of new and
  unique constellations in the sky.
  The number of stars, the degree of twinkling, and the moving speed can be
  specified by changing parameters below.
  Have fun!!

  Contents are licensed under [CC-BY-SA 3.0]
  (http://creativecommons.org/licenses/by-sa/3.0/)
  (Creative Commons Attribution-ShareAlike 3.0 Unported License).  
*/

////////////////////////////////////////////////////////////////////////////////////
int stars = 10000;                // Number of stars
float twinkle_coef = 0.25;        // 0.0 for no twinkling
float movement_x = 0.50;          // speed of orbital motion 
float movement_y = 0.05;          // speed of vertical movement
////////////////////////////////////////////////////////////////////////////////////

float[] star_size = new float[stars]; 
int[] star_R = new int[stars]; 
int[] star_G = new int[stars]; 
int[] star_B = new int[stars]; 
float[] star_x = new float[stars]; 
float[] star_y = new float[stars]; 
float[] twinkle = new float[stars]; 
int brightness;
boolean setLocation_flag;


///// configuration ////////////////////////////////////////////////////

void setup() { 

  // full screan (this code is for Processing 2.x only)
  frame.removeNotify();
  frame.setUndecorated(true);
  frame.addNotify();
  size(displayWidth, displayHeight);
  setLocation_flag = true;

  // define properties of stars
  for(int i=0; i<stars; i++){
    star_size[i] = pow(random(1.15),8)+1.0;
    brightness = round(random(255));
    star_R[i] = round((128+random(128))*brightness/144);
    star_G[i] = round((128+random(128))*brightness/255);
    star_B[i] = round((128+random(128))*brightness/144);
    star_x[i] = random(width);
    star_y[i] = random(height);
  }

}


///// main loop ////////////////////////////////////////////////////
void draw(){
  
  // only run at the first time (Processing 2.x only)
  if (setLocation_flag) {
    frame.setLocation(0, 0);
    setLocation_flag=false;
  }

  // clear window
  background(0); 
  noStroke();

  // Decide twinkle parameter for each star
  for(int i=0; i<stars; i++){
    twinkle[i] = (1-twinkle_coef)+twinkle_coef*(random(100)/100);
  }

  // dark & larger circle
  for(int i=0; i<stars; i++){
    fill(round(star_R[i]*twinkle[i]*0.2), round(star_G[i]*twinkle[i]*0.2), round(star_B[i]*twinkle[i]*0.2)); 
    ellipse((star_x[i]), (star_y[i]), star_size[i]*2, star_size[i]*2); 
  }
  // middle circle
  for(int i=0; i<stars; i++){
    fill(round(star_R[i]*twinkle[i]*0.5), round(star_G[i]*twinkle[i]*0.5), round(star_B[i]*twinkle[i]*0.5)); 
    ellipse((star_x[i]), (star_y[i]), star_size[i]*1.5, star_size[i]*1.5); 
  }
  // core
  for(int i=0; i<stars; i++){
    fill(round(star_R[i]*twinkle[i]), round(star_G[i]*twinkle[i]), round(star_B[i]*twinkle[i])); 
    ellipse((star_x[i]), (star_y[i]), star_size[i], star_size[i]); 
  }

  // movement
  for(int i=0; i<stars; i++){
    star_x[i] += movement_x;
    if(star_x[i] > width ) star_x[i] -= width;
    if(star_x[i] < 0 ) star_x[i] += width;
    star_y[i] += movement_y;
    if(star_y[i] > height ) star_y[i] -= height;
    if(star_y[i] < 0 ) star_y[i] += height;
  }

}

