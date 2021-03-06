// Some global constants. Final keyword stops these being
// accidentally redefined elsewhere.
final int[][] scales = {  
  {0 , 2 , 4 , 5 , 7 , 9, 11, 12, 14, 16, 17, 19, 21, 23, 24, 26, 28, 29, 31, 33, 35, 36, 38, 40, 41, 43, 45, 47, 48} /*Ionian*/,
  {0 , 2 , 3 , 5 , 7 , 9, 10, 12, 14, 15, 17, 19, 21, 22, 24, 26, 27, 29, 31, 32, 34, 36, 38, 39, 41, 43, 45, 46, 48} /*Dorian*/,
  {0 , 1 , 3 , 5 , 7 , 8, 10, 12, 13, 15, 17, 19, 20, 22, 24, 25, 27, 29, 31, 32, 34, 36, 37, 49, 41, 43, 44, 46, 48} /*Phrygian*/,
  {0 , 2 , 4 , 6 , 7 , 9, 11, 12, 14, 16, 18, 19, 21, 23, 24, 26, 28, 30, 31, 33, 35, 36, 38, 40, 42, 43, 45, 47, 48} /*Lydian*/,
  {0 , 2 , 4 , 5 , 7 , 9, 10, 12, 14, 16, 17, 19, 21, 22, 24, 26, 28, 29, 31, 33, 34, 36, 38, 40, 41, 43, 45, 46, 48} /*Mixolydian*/,
  {0 , 2 , 3 , 5 , 7 , 8, 10, 12, 14, 15, 17, 19, 20, 22, 24, 26, 27, 29, 31, 32, 34, 36, 38, 40, 41, 43, 44, 46, 48} /*Aeolian*/,
  {0 , 1 , 3 , 5 , 6 , 8, 10, 12, 13, 16, 17, 18, 20, 22, 24, 25, 28, 29, 30, 32, 34, 36, 37, 49, 41, 42, 44, 46, 48} /*Locrian*/
};

final int[] timing = {125, 250, 500, 1000, 2000};