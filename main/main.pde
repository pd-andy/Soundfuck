import org.puredata.processing.*;
import java.util.Arrays;

Soundfuck sf = new Soundfuck();
PureData  pd;

String sfFilePath;
String sfFileText;
int[]  sfArray;
int    sfArrayP;
int    sfRootNote;
int[]  sfScale;
int    sfNoteLength;
ArrayList<String> sfMusic = new ArrayList<String>();
int    sfMusicP;

boolean isPlaying = false;

int scrollAmt = 0;

void setup() {
  size(640, 202);
  background(0);
  
  // A PureData object must recieve reference the processing
  // PApplet (couldn't work out how to do this without the
  // 'this' keyword, this meant that the audio functionality
  // couldn't  be contained in the Soundfuck class).
  // (PApplet, sampleRate, inputs, outputs)
  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("pd/main.pd");
  // Start turns on DSP.
  pd.start();
  
}

void draw() {
  // Refresh background.
  background(0);
  fill(0, 255, 0);
  drawInfo();
  fill(0);
  rect(0, 0, width, 20);
  fill(0, 255, 0);
  // Text loads a default font if no specific one is loaded.
  if(!isPlaying)text("Press Enter to load a file.", 0, 10);
  else text("Press Enter to stop.", 0, 10);
  
  
}

void keyPressed() {
  switch (keyCode) {
    // ENTER and RETURN redundancy for UNIX/Windows systems.
    case ENTER:
      if(!isPlaying) {
        isPlaying = true;
        selectInput("Select a .sf file.", "inputCallback");
      } else {
        isPlaying = false;
      }
      break;
    case RETURN:
      if(!isPlaying) {
        isPlaying = true;
        selectInput("Select a .sf file.", "inputCallback");
      } else {
        isPlaying = false;
      }
      break;
    // Simple way to scroll up and down the display of the script.
    case UP:
        scrollAmt-=10;
        break;
    case DOWN:
        scrollAmt+=10;
      break;
  }
}

void drawInfo() {
  // Matrix for the translation.
  pushMatrix();
    translate(0, scrollAmt);
    text("File loaded at: " + sfFilePath, 0, 30);
    for(int i = 0; i < sfMusic.size(); i++) {
    int y = 50+i*10;
    text(i + ") " + sfMusic.get(i), 0, y);
  }
  // Highlight the active music beat.
  rect(0, 40+sfMusicP*10, 10, 10);
  popMatrix();
}