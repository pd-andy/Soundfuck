# Soundfuck
A livecoding brainfuck interpreter written in Processing + Pd

[![Livecoding a basic beat](https://github.com/pd-andy/Soundfuck/blob/master/media/Example%20Screenshot_1.png)](https://vimeo.com/198578860)

## What is it?
Soundfuck is the answer to the question "How can we make writing music as unintuitive as possible?" Soundfuck (Sf for short) is an interpreter for the somewhat infamous esolang Brainfuck. Making use of a lexicon of just 8 characters, it is possible to write fairly complicated music; complete with key modulation and access to the 7 western modes.

## OK but why?
Sf began as a small experiment to have some fun with Brainfuck. Now though, the project has evolved to challenge conventional music making practice. When writing we tend to think in what I call 'horizontal blocks', that is, chunks of music going from left to right. Additionally it can be easy to think on a instrument-by-instrument or track-by-track basis; "first the melody will go like this, and under it I'll add these chords..." etc. I like to think Sf challenges that way of thinking and forces the composer to think 'vertically'. In order to effectively compose in Sf you must compose moment-by-moment, considering what each track is doing before moving on to the next step.

[![A simple melody and drum beat](https://github.com/pd-andy/Soundfuck/blob/master/media/Example%20Screenshot_2.png)](https://vimeo.com/198584939)

## I'm a glutton for punishment, how does it work?

To compose in Soundfuck you must traverse an array with (for now at least) 14 indexes, simply incrementing or decrementing the value at any given index. Unlike Brainfuck however, each index of the Sf array serves a set purpose:

| Index | Function                                        |
| ----- | ----------------------------------------------- |
| 0     | Sets the root of the scale: C - B               |
| 1     | Sets the current scale/mode, starting at Ionian |
| 2     | Sets the current timing measure: 1/16 - 1 notes |
| -     | -                                               |
| 3     | The first synth voice.                          |
| 4     | The second synth voice.                         |
| 5     | The third synth voice.                          |
| 6     | The fourth synth voice.                         |
| -     | -                                               |
| 7     | Drum voice: Kick                                |
| 8     | Drum voice: Snare                               |
| 9     | Drum voice: Closed HH                           |
| 10    | Drum voice: Open HH                             |
| 11    | Drum voice: Crash                               |
| 12    | Drum voice: Perc 1                              |
| 13    | Drum voice: Perc 2                              |

To navigate the array and perform in Sf we have the following lexicon:

| Character | Function                                                                   |
| --------- | -------------------------------------------------------------------------- |
| >         | Move to the next index in the array. This wraps around.                    |
| <         | Move to the previous index in the array. This wraps around.                |
| +         | Increment the current index by 1.                                          |
| -         | Decrement the current index by 1.                                          |
| .         | Synth voice: Trigger a note on. Drum Voice: Trigger high velocity note on. |
| ,         | Synth voice: Trigger a note off. Drum Voice: Trigger low velocity note on. |
| [         | Group the commands into a musical beat.                                    |
| ]         | Stop grouping commands into the current beat.                              |

## I'm going to need some examples...
To get an idea of what a simple Soundfuck patch might look like, let's take a look at a drum beat.
```
# The third index controls the duration of the beat
>>
# Increment 1 for 1/8 note length
+
# Drum voices start at index 7
>>>>>
# Write the groove
#1 [.>>.]
#& [,]
#2 [.<.]
#& [<.>>,]
#3 [.]
#& [<<.>>,]
#4 [.<.]
#& [>,]
```
Notice how we don't move the poiner back down in the final beat. Sf resets and rereads the patch at the end of every loop. Taking a look at a short melody that spans two synth voices, we can see the patch getting more complicated now.
```
# Set the root note to c#
+
# Set the scale to natural minor (Aeolian mode)
>+++++
# Beat timing to 1/8 notes
>+
# Synth voices start at index 3
>
# Shift up an octave so we can go below the root note
+++++++
# Up three octaves for the melody
>+++++++++++++++++++++<
# Write the melody
#1 [.>----.]
#& [-.]
#2 []
#& [,<,]
#3 [++.>.]
#& []
#4 []
#& []
#1 [-.<---.]
#& []
#2 [-.>+.]
#& []
#3 [<,>,+++++]
#& [.]
#4 [-.]
#& [--.]
#1 [<++.>-.]
#& [-.]
#2 []
#& [,<,]
#3 [++.>.]
#& []
#4 []
#& []
#1 [--.<---.]
#& []
#2 [-.>-.]
#& []
#3 [<,>,++++++++]
#& [.]
#4 [-.]
#& [--.]
```
Finally let's cut that melody in half and put a drum beat under it.
```
# Set the root note to c#
+
# Set the scale to natural minor (Aeolian mode)
>+++++
# Beat timing to 1/8 notes
>+
# Synth voices start at index 3
>
# Shift up an octave so we can go below the root note
+++++++
# Up three octaves for the melody
>+++++++++++++++++++++<
# Write the loop
#1 [.>----.>>>.]
#& [<<<-.>>>>>>.]
#2 [<<.<<<<]
#& [,<,>>>>>>>.]
#3 [<<<.<<<<.++.>.]
#& [>>>>>>.]
#4 [<<.]
#& [>>.]
#1 [<<<.<<<-.<---.]
#& [>>>>>>>.]
#2 [<<.<<<<<-.>+.]
#& [>>>>>>.]
#3 [<<<.<<<<,>,]
#& [+++++.>>>>>>.]
#4 [<<.<<<<-.]
#& [--.>>>>>>.]
```
Notice how within each block of commands the pointer is mostly ever going in one direction, this is a result of 'vertical' composing. 
