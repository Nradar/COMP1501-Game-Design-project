// Class for animating a sequence of GIFs
boolean isfacingRight = true;  //whether the stickman is facing right
boolean isWalking = false;  //whether the stickman is walking
boolean isfacingCurve = false;  //whether the stickman is on the curve or the flat ground
boolean iscurveUpr = false; //whether the stickman is walking upcurve or below curve on right side of the screen
boolean iscurveUpl = false; //whether the stickman is walking upcurve or below curve on left side of the screen
float walkingSpeed = 12;
String upordown;

class Animation {
  PImage[] images;
  int imageCount;
  int frame;
  
  Animation(String imagePrefix, int count) {
    imageCount = count;
    images = new PImage[imageCount];

    for (int i = 0; i < imageCount; i++) {
      // Use nf() to number format 'i' into four digits
      String filename = imagePrefix + nf(i, 4) + ".gif";
      images[i] = loadImage(filename);
    }
  }

  void display(float xpos, float ypos) {
    frame = (frame+1) % imageCount;
    image(images[frame], xpos, ypos);
  }
  
  int getWidth() {
    return images[0].width;
  }
  int getHeight() {
    return images[0].height;
  }
}

void walking(){
  //determine the direction
  if (keyPressed == true){
    if (key == CODED){
      if (keyCode == RIGHT){
        isfacingRight = true;
        isWalking = true;
      }
      if (keyCode == LEFT){
        isfacingRight = false;
        isWalking = true;
      }
    }
  }
  else {
    isWalking = false;
  }
  
  //BOOLEANS!!!
  //right curve determine
  if (walking_x > tsx3 && walking_x < tsx4){
    isfacingCurve = true;
  }
  //left curve determine
  else if (walking_x < tsx2 && walking_x > tsx1){
    if (walking_y > button1_y && walking_y < button3_y){
      isfacingCurve = true;
    }
  }
  else{
    isfacingCurve = false;
  }
  
  //if the stickman is walking up
  if (walking_x > buttonUD1_x - buttonUD1_width/2 && walking_x < buttonUD1_x + buttonUD1_width/2 && walking_y + walkingRF.getHeight() > tsy4 && walking_y + walkingRF.getHeight() < tsy1){
    if (keyPressed == true){
      if (keyCode == UP){
        iscurveUpr = true;
        fill (255,255,255);
        text("UP", buttonUD1_x - 100, buttonUD1_y - 100);
      }
      if (keyCode == DOWN){
        iscurveUpr = false; 
        fill (255,255,255);
        text("DOWN", buttonUD1_x - 100, buttonUD1_y - 100);
      }
    }
  }
  
  //execute walking
  if (isWalking == true){
    //mid flat ground walking
    if (isfacingRight == true){
      walking_x += walkingSpeed;
      walkingRF.display(walking_x, walking_y);
    }
    if(isfacingRight ==  false){
      walking_x -= walkingSpeed;
      walkingLF.display(walking_x, walking_y);
    }
    //first right curve walking
    if (isfacingCurve == true && isfacingRight == true && iscurveUpr == false){
      walking_y -= walkingSpeed*(tsy1 - tsy2)/(tsx4 - tsx3);
    }
    if(isfacingCurve == true && isfacingRight == false && iscurveUpr == false){
      walking_y += walkingSpeed*(tsy1 - tsy2)/(tsx4 - tsx3);
    }
    if(isfacingCurve == true && isfacingRight == true && iscurveUpr == true){
      walking_y += walkingSpeed*(tsy1 - tsy2)/(tsx4 - tsx3);
    }
    if(isfacingCurve == true && isfacingRight == false && iscurveUpr == true){
      walking_y -= walkingSpeed*(tsy1 - tsy2)/(tsx4 - tsx3);
    }
  }
  //standing image
  //if the stickman is not walking then show standing image at that position
  else if(isfacingRight == true){
    image(standingRF,walking_x,walking_y);
    }
    else {
      image(standingLF,walking_x,walking_y);
    }
}