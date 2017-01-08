// Due do the way Processing handles its thread() function, it's not possible //
// to encapsulate everythin into the Soundfuck class; specifically you cannot //
// create threads from within a class method and thus, the music thread and   //
// relevant methods can't be contained in the Soundfuck class.
// The Soundfuck class acts as an interface for loading and parsing a sf file.//
class Soundfuck {
  // Variables are set to private to avoid accidentally changing them elsehwere.
  // Class methods can be used to access and return these variables.
  private String filePath;  
  private String fileText;
  private int[] array = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  private int arrayP = 0;
  // ArrayLists are more or less equivalent to vectors.
  // Vectors are deprecated in Java.
  private ArrayList<String> music = new ArrayList<String>();
  private int musicP = 0;
  
  private void reset() {
    // Arrays.fill is an array method to set all indicies
    // to one value.
    Arrays.fill(array, 0);
    // Clear the ArrayList.
    music.clear();
    arrayP = 0;
    musicP = 0;
  }
  
  public void loadFile(File file) {
    
    filePath = file.getAbsolutePath();
    fileText = join(loadStrings(filePath), ' ');
  }
  
  // Conventially, prefixing an argument with an underscore
  // is a way of differentiating class variables to function
  // arguments. The same result could be achieved with filePath
  // and this.filePath.
  public void loadFromPath(String _filePath) {
    
    filePath = _filePath;
    fileText = join(loadStrings(filePath), ' ');
  }
  
  // This method parses the .sf file character by character.
  // A swtich/case statement is far more fitting here, although
  // functionally similar to if/else  statements, when checking
  // a value rather than a boolean, switch statements tend to
  // be more readable.
  public void readFile(String text) {
    reset();
    boolean WRITE = false;
    for (int i = 0; i < text.length(); i++) {
      String newString;
      switch (text.charAt(i)) {
        // Writing to the ArrayList is somewhat awkward.
        // There is no += method for the String, so we must
        // store the current contents, then append the new
        // character, then set the index to the new String.
        case '<':
          if(WRITE) {
            newString = music.get(musicP) + '<';
            music.set(musicP, newString);
          }
          // Wrap array pointer round.
          else arrayP = (arrayP - 1) % array.length;
          break;
        case '>':
          if(WRITE) {
            newString = music.get(musicP) + '>';
            music.set(musicP, newString);
          }
          // Wrap array pointer round.
          else arrayP = (arrayP + 1) % array.length;
          break;
        case '+':
          if(WRITE) {
            newString = music.get(musicP) + '+';
            music.set(musicP, newString);
          }
          else array[arrayP]++;
          break;
        case '-':
          if(WRITE) {
            newString = music.get(musicP) + '-';
            music.set(musicP, newString);
          }
          else array[arrayP]--;
          break;
        case '.':
          if(WRITE) {
            newString = music.get(musicP) + '.';
            music.set(musicP, newString);
          }
          break;
        case ',':
          if(WRITE) {
            newString = music.get(musicP) + ',';
            music.set(musicP, newString);
          }
          break;
        // By checking if write is false/true respectively,
        // we can ensure we aren't pushing erroneous cells
        // to the ArrayList.
        case '[':
          if(WRITE==false) {
            WRITE=true;
            music.add("");
          }
          break;
        case ']':
          if(WRITE==true) {
            WRITE = false;
            musicP++;
          }
          break;
      }
    }
  }
  
  // Methods for returning class variables.
  public String getText() {
    return fileText;
  }
  
  public String getPath() {
    return filePath;
  }
  
  public int[] getArray() {
    return array;
  }
  
  public int getArrayP() {
    return arrayP;
  }
  
  public ArrayList<String> getMusic() {
    return music;
  }
}