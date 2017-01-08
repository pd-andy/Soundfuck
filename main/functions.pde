void inputCallback(File file) {
  sf.loadFile(file);  
  sfFilePath = sf.getPath(); 
  sfFileText = sf.getText();
  sf.readFile(sfFileText);
  setValues();

  // thread() executes a function in a seperate thread
  // to avoid blocking the main draw thread.
  thread("play");
}

void setValues() {
  sfArray      = sf.getArray(); 
  sfArrayP     = sf.getArrayP();
  sfMusic      = sf.getMusic(); 
  sfRootNote   = sfArray[0]; 
  sfScale      = scales[sfArray[1]]; 
  sfNoteLength = timing[sfArray[2]];
}

void updateValues() {
  sfRootNote   = sfArray[0];  
  sfScale      = scales[sfArray[1]]; 
  sfNoteLength = timing[sfArray[2]];
}

void play() {
  sfMusicP = 0;
  // isPlaying bool allows play() to loop infinitely
  // in its own thread.
  while(isPlaying) {
    // If statement reloads the script at the start of everyloop.
    // Allows us to livecode while keeping in time.
    if(sfMusicP==0) {
      reset();
      sf.loadFromPath(sfFilePath);
      sfFileText = sf.getText();
      sf.readFile(sfFileText);
      setValues();
    }
    // Access ArrayLists with .get() rather than [].
    readMusic(sfMusic.get(sfMusicP)); 
    // Modulo wraps the pointer round so we can loop.
    sfMusicP = (sfMusicP+1) % sfMusic.size();
  }
  reset();
}

// Similar function to sf.readFile, with slightly different
// functionality. Any erroneous [ and ] are ignored and added
// switch statements for '.' and ',' to send messages to pd.
void readMusic(String phrase) {
  for (int i = 0; i < phrase.length(); i++) {
    switch (phrase.charAt(i)) {
      case '<':
        sfArrayP = (sfArrayP - 1) % sfArray.length;
        break;
      case '>':
        sfArrayP = (sfArrayP + 1) % sfArray.length;
        break;
      case '+':
        sfArray[sfArrayP]++;
        break;
      case '-':
        sfArray[sfArrayP]--;
        break;
      case '.':
        switch (sfArrayP) {
          case 3:
            // PureData doesn't distinguish ints from floats.
            // sfArray[3]%sfScale.length wraps notes round if they go out of bounds.
            pd.sendFloat("osc1", float(sfScale[sfArray[3]%sfScale.length] + sfRootNote));
            pd.sendFloat("noteOn1", 0.2);
            break;
          case 4:
            pd.sendFloat("osc2", float(sfScale[sfArray[4]%sfScale.length] + sfRootNote));
            pd.sendFloat("noteOn2", 0.2);
            break;
          case 5:
            pd.sendFloat("osc3", float(sfScale[sfArray[5]%sfScale.length] + sfRootNote));
            pd.sendFloat("noteOn3", 0.2);
            break;
          case 6:
            pd.sendFloat("osc4", float(sfScale[sfArray[6]%sfScale.length] + sfRootNote));
            pd.sendFloat("noteOn4", 0.2);
            break;
          case 7:
            pd.sendFloat("drumVel1", 0.2);
            pd.sendBang("drum1");
            break;
          case 8:
            pd.sendFloat("drumVel2", 0.2);
            pd.sendBang("drum2");
            break;
          case 9:
            pd.sendFloat("drumVel3", 0.2);
            pd.sendBang("drum3");
            break;
          case 10:
            pd.sendFloat("drumVel4", 0.2);
            pd.sendBang("drum4");
            break;
          case 11:
            pd.sendFloat("drumVel5", 0.2);
            pd.sendBang("drum5");
            break;
          case 12:
            pd.sendFloat("drumVel6", 0.2);
            pd.sendBang("drum6");
            break;
          case 13:
            pd.sendFloat("drumVel7", 0.2);
            pd.sendBang("drum7");
            break;
        }
        break;
      case ',':
        switch (sfArrayP) {
          case 3:
            pd.sendFloat("noteOn1", 0);
            break;
          case 4:
            pd.sendFloat("noteOn2", 0);
            break;
          case 5:
            pd.sendFloat("noteOn3", 0);
            break;
          case 6:
            pd.sendFloat("noteOn4", 0);
            break;
          case 7:
            pd.sendFloat("drumVel1", 0.1);
            pd.sendBang("drum1");
            break;
          case 8:
            pd.sendFloat("drumVel2", 0.1);
            pd.sendBang("drum2");
            break;
          case 9:
            pd.sendFloat("drumVel3", 0.1);
            pd.sendBang("drum3");
            break;
          case 10:
            pd.sendFloat("drumVel4", 0.1);
            pd.sendBang("drum4");
            break;
          case 11:
            pd.sendFloat("drumVel5", 0.1);
            pd.sendBang("drum5");
            break;
          case 12:
            pd.sendFloat("drumVel6", 0.1);
            pd.sendBang("drum6");
            break;
          case 13:
            pd.sendFloat("drumVel7", 0.1);
            pd.sendBang("drum7");
            break;
        }
        break;
    }
    updateValues();
  }
  // Delaying the thread to achieve musical timing.
  delay(sfNoteLength);
}

void reset() {
  sfArray = new int[14];
  // clear() method removes all elements in an ArrayList.
  sfMusic.clear();
  
  sfArrayP = 0;
  sfMusicP = 0;
  
  // Mute all synth voices.
  pd.sendFloat("noteOn1", 0);
  pd.sendFloat("noteOn2", 0);
  pd.sendFloat("noteOn3", 0);
  pd.sendFloat("noteOn4", 0);
}