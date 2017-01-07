class Soundfuck {
  private String filePath;  
  private String fileText;
  
  private int[] array = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
  private int arrayP = 0;
  private ArrayList<String> music = new ArrayList<String>();
  private int musicP = 0;
  
  private void reset() {
    Arrays.fill(array, 0);
    arrayP = 0;
    musicP = 0;
  }
  
  public void loadFile(File file) {
    reset();
    
    filePath = file.getAbsolutePath();
    fileText = join(loadStrings(filePath), ' ');
  }
  
  public void loadFromPath(String _filePath) {
    reset();
    
    filePath = _filePath;
    fileText = join(loadStrings(filePath), ' ');
  }
  
  public void readFile(String text) {
    boolean WRITE = false;
    musicP = 0;
    for (int i = 0; i < text.length(); i++) {
      String newString;
      switch (text.charAt(i)) {
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
    music.trimToSize();
    musicP = 0;
  }
  
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