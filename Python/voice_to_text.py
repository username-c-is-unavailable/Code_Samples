# Author: username-c-is-unavailable;

""" 
  Purpose: Converts speech to text, using Google's API.
           Copies the text to the clipboard, so that it can be pasted anywhere desired.      
"""
import speech_recognition as sr  
import pyperclip
import sys



# Get audio from the active microphone device.                                                                    
recognizer = sr.Recognizer()  

# Functions-------------------------------------------------------------------------------------------------------------------

"""
Paste the audio text to the clipboard.
"""
def paste_to_clipboard(audio_text):

    # Copy and paste the text to the clipboard of the OS.
    pyperclip.copy(audio_text)
    pyperclip.paste()


"""
Accept an input string and convert it to proper case by capitalizing the first word of the sentence.
Additionally, add a '.' to the end of the sentence if audio_text is not a question.
"""
def proper_case(audio_text):

    # Split the text into an array so we can manipulate it.
    text_array = audio_text.split()
    
    # Capitalize the first word in the sentence.
    text_array[0] = text_array[0].capitalize()

    # If there is not a '?' in the last element of the array, then add a period.
    if not '?' in (text_array[len(text_array) - 1]):
        text_array[len(text_array) - 1] = text_array[len(text_array) - 1] + '.'

    # Rejoin the text from the array back into a single string.
    audio_text = ' '.join(text_array)

    return audio_text


def main():


    # Get the audio input from the microphone.
    with sr.Microphone() as audio_source:                                                                            
        raw_audio = recognizer.listen(audio_source)   

    try:
        # Send the audio to Google's API and get back a text result.
        audio_text = recognizer.recognize_google(raw_audio)

        # Fix any casing issues, print the text to clipboard, and write it to a file.
        corrected_audio_text = proper_case(audio_text) 
        paste_to_clipboard(corrected_audio_text)
        print('You said: "' + corrected_audio_text + "\"")

    except sr.UnknownValueError:
        print("Sorry, I couldn't hear that.")

    except sr.RequestError as e:
        print("There was some request error.; {0}".format(e))
    

# Call the main() function.
if __name__ == '__main__':
    main()