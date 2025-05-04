# The Python Pizza Deliveries

print("Welcome to Python Pizza Deliveries!\n ")

size = input("What size pizza do you want? s, m or l:\n")

pepperoni = input("Do you want pepperoni on your pizza? y or n:\n")

extra_cheese = input("Do you want extra cheese?\n")

bill = 0

# Work out how much they need to pay based on their size choice
# Small = $15
# Medium = $20
# Large = $25
if size == "s":
    bill += 15
elif size == "m":
    bill += 20
elif size == "l":
    bill += 25
    
else:
    print("Please choose the provide options.")


# Work out how much to add to their bill based on their pepperoni choice.
    # Pepperoni on s = $2
    # Pepperoni on m or l = $3
if pepperoni == "y" and size == "s":
    bill += 2
elif pepperoni == "y" and size == "m" or pepperoni == "y" and size == "l":
    bill += 3
        
        

# Work out their final amount based on whether they want extra cheese
if extra_cheese == "y":
    bill += 1
else:
    pass
    
print(f"Your final bill is ${bill}.")
