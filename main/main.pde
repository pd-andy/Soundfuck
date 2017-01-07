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
ArrayList<String> sfMusic;
int    sfMusicP;

boolean isPlaying = false;

void setup() {
  size(640, 202);
  background(0);
  
  pd = new PureData(this, 44100, 0, 2);
  pd.openPatch("pd/main.pd");
  pd.start();
  
}

void draw() {

}

void keyPressed() {
  switch (keyCode) {
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
  }
}