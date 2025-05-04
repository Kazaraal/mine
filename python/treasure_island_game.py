# The Treasure Island
image = '''
*******************************************************************************
          |                   |                  |                     |
 _________|________________.=""_;=.______________|_____________________|_______
|                   |  ,-"_,=""     `"=.|                  |
|___________________|__"=._o`"-._        `"=.______________|___________________
          |                `"=._o`"=._      _`"=._                     |
 _________|_____________________:=._o "=._."_.-="'"=.__________________|_______
|                   |    __.--" , ; `"=._o." ,-"""-._ ".   |
|___________________|_._"  ,. .` ` `` ,  `"-._"-._   ". '__|___________________
          |           |o`"=._` , "` `; .". ,  "-._"-._; ;              |
 _________|___________| ;`-.o`"=._; ." ` '`."\` . "-._ /_______________|_______
|                   | |o;    `"-.o`"=._``  '` " ,__.--o;   |
|___________________|_| ;     (#) `-.o `"=.`_.--"_o.-; ;___|___________________
____/______/______/___|o;._    "      `".o|o_.--"    ;o;____/______/______/____
/______/______/______/_"=._o--._        ; | ;        ; ;/______/______/______/_
____/______/______/______/__"=._o--._   ;o|o;     _._;o;____/______/______/____
/______/______/______/______/____"=._o._; | ;_.--"o.--"_/______/______/______/_
____/______/______/______/______/_____"=.o|o_.--""___/______/______/______/____
/______/______/______/______/______/______/______/______/______/______/[TomekK]
*******************************************************************************
'''

print(image)
print("Welcome to Treasure Island.\n\n\nYour mission is to find the treasure.\n\n")

# Stage 1
turn = input("You're at a cross road. Where do you want to go?\n\nType 'left' or 'right'\n")

if turn == "left":
    # On the left turn
    lake = input("\nYou've come to a lake. There is an island in the middle of the lake.\n\nType 'wait' to wait for the boat. Type 'swim' to swim across.\n")
    if lake == "wait":
        # Wait for the boat
        house = input("\nYou arrive at the island unharmed. There is a house with 3 doors. One red, one yellow and one blue.\n\nWhich colour do you choose?\n")
        if house == "red":
            # Red door
            print("\nIt's a room full of fire. Game Over.")
        elif house == "blue":
            # Blue door
            print("\nYou enter a room of beasts. Game Over.")
        elif house == "yellow":
            # Yellow door
            print("\nYou found the treasure! You Win!")


    elif lake == "swim":
        # Swim
        print("\nYou get attacked by an angry trout. Game Over")
else:
    # On the right turn
    print("\nYou fell into a hole. Game Over.")

