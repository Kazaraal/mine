# Check if they meet the critirea to ride the rollercoater

height = int(input("What is your height?\n"))
age    = int(input("What is your age?\n"))
bill = 0

if height >= 120:
    print("You are the right height.")
    if age <= 12:
        print("You will pay $5 for the ride.")
        bill += 5
    elif age <= 18:
        print("You will pay $7 for the ride..")
        bill += 7
    elif age > 18:
        print("You will pay $12 for the ride..")
        bill += 12
    
    # Inquire if they want a photo taken
    want_photo = input("Do you want a photo taken? yes or no\n")
    
    if want_photo == "yes":
        print("That photo will cost you $3.")
        bill += 3
        print(f"Your bill will be ${bill}.")
    else:
        print(f"You are welcome to our Rollercoaster ride. Your bill will be ${bill}.")
        
else:
    print("You are not the right height.")