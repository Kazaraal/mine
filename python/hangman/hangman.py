import random
from hangman_logo import hangman_logo
from hangman_pics import HANGMANPICS
from word_list import word_list

print(hangman_logo)

# TODO-1    Randomly choose a word from the word_list and assign it to a variable called chosen_word. 
#           Then print it.
chosen_word = random.choice(word_list)

print(chosen_word)

# TODO-1.2  Create an empty string called placeholder
placeholder = ""

# TODO-1.3  For each letter in the chosen_word, add a _ to placeholder. So if the chosen_word was "apple", 
#           placeholder should be _ _ _ _ _ with 5 "_" representing each letter to guess.
word_length = len(chosen_word)

for letter in range(word_length):
    placeholder += "_ "
print(placeholder)

# TODO-1.4  Use a while loop to let the user guess again. The loop should only stop once the user has 
#           guessed all the letters in the chosen_word. At that point display has no more blanks ("_").
#           Then you can tell the user they have won.

game_over = False

correct_letter = []

# TODO-1.5  Create a variable called lives to keep track of the number of lives left.
#           Set lives to equal 0.
lives = 0

no_of_images = len(HANGMANPICS)
# print(no_of_images)


while not game_over:

    # TODO-2.4    Show the remianing lives
    print(f"*************************<<< {lives}/6 LIVES SPENT >>>*****************************************")

    # TODO-2      Ask the user to guess a letter and assign their answer to a varialble called guess. 
    #             Make guess lowercase.
    guess = input("Guess a letter from the chosen_word.\n").lower()

    # TODO-2.3    If the user has entered a letter they have already guessed, print the letter and let them know
    if guess in correct_letter:
        print(f"You have already guessed {guess}. Please try again.")


    # TODO-2.2  Create an empty string called "display".
    display = ""

    # TODO-3    Check if the letter the user guessed (guess) is one of the letters in the chosen_word. Print "Right" if it is. "Wrong" if it isn't.

    for letter in chosen_word:
        if letter == guess:
            print("Right")

    # TODO-3.2  Loop through each letter in the chosen_word. If the letter at that position matches guess, 
    #           then reveal that letter in the display at that position. e.g If the user guessed "p" and 
    #           the chosen_word was "apple", then display should be _ p p _ _.
            display += letter

    # TODO-3.4  Update the for loop so that previous guesses are added to the display string. At the moment, when the
    #           user makes a new guess, the previous guess gets replaced by a "_". We need to fix that by updating
    #           the loop.
            correct_letter.append(guess)

        elif letter in correct_letter:
            display += letter

    # TODO-3.3  Print display and you should see the guessed letter in the correct position.
    #           But every letter that is not a match is still represented with a "_".

        else:
            print("Wrong")
            display += "_ "

# TODO-3.4  If guess is not a letter in the chosen_word, then reduce lives by 1. If 
#           lives goes down to 0. then the game should end, and it should print
#           "You lose."
    if guess not in chosen_word:
        lives += 1
        print(f"{guess} is not in the word. You lose a life.")
        if lives == 6:
            game_over = True
            print(f"############<<< You lose. The word was {chosen_word}.>>>#############")

    print(display)
    # print(correct_letter)
    print(HANGMANPICS[lives])
    # print(lives)

    if "_ " not in display:
        game_over = True
        print("############<<< You win! >>>#############")