// Welcome to Soundfuck, the livecoding music language nobody asked for.     //
// Soundfuck borrows the lexicon and basic paradigm of the esolang Brainfuck //
// with a few changes.                                                       //
// The lexicon of Soundfuck is as follows:                                   //
// >  : Move the pointer to the next index.                                  //
// <  : Move the pointer to the previous index.                              //
// +  : Increment the value at the pointer by 1.                             //
// -  : Decrement the value at the pointer by 1.                             //
// [  : Begin writing a new beat.                                            //
// ]  : Stop writing the current beat.                                       //
// The following two commands apply only to indexes 3-13.                    //
// .  : If the pointer points to a synth voice, play the voice.              //
//      If the pointer points to a drum voice, play the voice.               //
// ,  : If the pointer points to a synth voice, stop the voice.              //
//      If the pointer points to a drum voice, play the voice quieter.       //
//---------------------------------------------------------------------------//
// Music can be written only through interacting with the main array, with   //
// each index only capable of simple incrementing and decrementing. Each     //
// index is associated with a different value of object:                     //
// array[0]  = The root note of the scale.                                   //
// array[1]  = The scale or mode.                                            //
// array[2]  = The duration of each beat (more on this in a second).         //
// array[3]  = Synth voice 1.                                                //
// array[4]  = Synth voice 2.                                                //
// array[5]  = Synth voice 3.                                                //
// array[6]  = Synth voice 4.                                                //
// array[7]  = Drum voice: Kick.                                             //
// array[8]  = Drum voice: Snare.                                            //
// array[9]  = Drum voice: Closed Hi Hat.                                    //
// array[10] = Drum voice: Open Hi Hat.                                      //
// array[11] = Drum voice: Crash Cymbal.                                     //
// array[12] = Drum voice: Percussion 1.                                     //
// array[13] = Drum voice: Percussion 2.                                     //
//---------------------------------------------------------------------------//
// When a script is loaded, commands contained inside square brackets [...]  //
// are not executed, but written to an ArrayList which is then looped in a   //
// seperate thread. Every time the entirety of the ArrayList is read, the    //
// script is also reread, thus enabling live coding of the piece. By making  //
// use of an ArrayList, the piece can vary in length.                        //
//---------------------------------------------------------------------------//
// The audio backend is run by Puredata, making use of libpd and the puredata//
// processing library. 