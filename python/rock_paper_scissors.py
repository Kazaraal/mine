# scissors cutting paper, paper covering rock, and rock crushing scissors

import random

# Rock Paper Scissors ASCII Art

# Rock
rock = """

rock
    _______
---'   ____)
      (_____)
      (_____)
      (____)
---.__(___)
"""

# Paper
paper = """

paper

     _______
---'    ____)____
           ______)
          _______)
         _______)
---.__________)

"""

# Scissors
scissors = """

scissors

    _______
---'   ____)____
          ______)
       __________)
      (____)
---.__(___)

"""

game_images = [rock, paper, scissors]

 
# User's choice and image
user_guess = int(input("Please choose 0 for rock, 1 for paper or 2 for scissors.\n"))
user_image = game_images[user_guess]

# Computer's guess and image
computer_guess = random.randint(0, 2)
computer_image = game_images[computer_guess]
 

print(f"The computer guessed {computer_guess}.")
print(f"The computer's image is {computer_image}")
print(f"Your image choice is {user_image}")

 

if user_guess == computer_guess:

    print("You get another try.")

elif computer_guess == 0 and user_guess == 1:

    print("You win")

elif computer_guess == 1 and user_guess == 0:

    print("You lose")

elif computer_guess == 0 and user_guess == 2:

    print("You lose")

elif computer_guess == 2 and user_guess == 0:

    print("You win")

elif computer_guess == 1 and user_guess == 2:

    print("You win")

elif computer_guess == 2 and user_guess == 1:

    print("You lose")