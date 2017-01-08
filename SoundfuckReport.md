# Soundfuck Report
Thoughts and descriptions of the underlying process.

## The concept
As mentioned in the readme, Soundfuck is an interpretation of the Brainfuck language for livecoding music. I won't get into detailing the array and its function in the program here: I would however, like to demonstrate the overall flow and structure of the program.

| Program Structure           |
|:---------------------------:|
| Create Pd instance          |
| ↓                           |
| Load & Read file            |
| ↓                           |
| Update array and variables  |
| ↓                           |
| Create new thread and play  |

### Create Pd instance
The program beings by creating and starting an instance of Pure Data. The libpd project allows pd to be embedded in a number of languages and provides an API to send and recieve messages and audio between the host program and the pd patch. To init we provide the Pd object a reference to the PApplet, the desired sample rate, and the necessary number of I/Os.
```java
Pd = new PureData(this, 44100, 0, 2);
```
We can the point Pd to the patch we want it to load up, relative to the Processing sketch's data folder, and then turn DSP processing on:
```java
Pd.openPatch("pd/main.pd");
Pd.start();
```

### Load & Read the file
Loading the file is relatively straight forward. When loading a new file the ```selectInput()``` Processing method is called, displaying a prompt to select a file and then executing a callback function.
```java
selectInput("Select a .sf file.", "inputCallback");
```
The callback automatically passes a File object to the function, from that we can grab the path to the file and load the text.
```java
filePath = file.getAbsolutePath();
fileText = join(loadStrings(filePath), ' ');
```
the ```join()``` method joins an array of Strings (each line of a text file) together using a character.

#### Reading the file
Psuedocode can help demonstrate how the text file is parsed. A switch statement cycles each character of the generated string, performing the function prescribed to it in the Soundfuck lexicon. Illegal characters are ignored.
```java
for(int i = 0; i < fileText.length(); i++) {
  switch (fileText.charAt(i) {
    case '>':
      arrayPointer++;
      break;
    case '+':
      array[arrayPointer]++
      break;
    case '[':
      music.pushBack("");
      break;
    ...
  }
}
```

### Update array and variables
A fairly simple step. We copy the array generated from reading the file over to the main sketch and base some Soundfuck variables from it; root note, scale, and musical timing. We'll also grab the generated ArrayList containing the instructions for each beat of music.
```java
void setValues() {
  sfArray      = sf.getArray(); 
  sfArrayP     = sf.getArrayP();
  sfMusic      = sf.getMusic(); 
  sfRootNote   = sfArray[0]; 
  sfScale      = scales[sfArray[1]]; 
  sfNoteLength = timing[sfArray[2]];
}
```

### Create new thread and play
Finally we create a new thread using Processing's simple wrapper:
```java
isPlaying = true;
thread("play");
```
And begin looping through our ArrayList of music commands:
```java
void play() {
  ...
  while(isPlaying) {
    ...
    readMusic(sfMusic.get(sfMusicP)); 
    sfMusicP = (sfMusicP+1) % sfMusic.size();
  }
  ...
}
```
There's some extra stuff going on in the ```play()``` function that we don't need to worry about right now. Taking a look at ```readMusic()``` we can see a similar switch statement to the one earlier, with some slight differences; we now have some cases to handle actually *performing* the music, and omitted casses for ```[``` and ```]```. 
```java
for(int i = 0; i < musicBeat.length(); i++) {
  switch (musicBeat.charAt(i) {
    case '>':
      arrayPointer++;
      break;
    case '+':
      array[arrayPointer]++
      break;
    case '.':
      // Another switch here to check which channel to control
      ...
      pd.sendFloat("osc1", float(sfScale[sfArray[3]] + sfRootNote));
      // OR
      pd.sendBang("drum1");
      break;
    ...
  }
}
```
