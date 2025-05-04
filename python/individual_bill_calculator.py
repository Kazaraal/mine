# This is a calculator which calculates the tip and how much each person is going to pay
print("Welcome tho the Tip Calculator.")
total_bill = int(input("What is the total bill? "))
tip = int(input("How much tip would you like to give? 10, 12 or 15. "))
no_of_people = int(input("How many people will split the bill? "))

actual_tip = 0
individual_payment = 0

# The logic to calculate the tip
if tip == 10:
    actual_tip = total_bill*0.1
elif tip == 12:
    actual_tip = total_bill*0.12
elif tip == 15:
    actual_tip = total_bill*0.15
else:
    print("Please choose the provided tips")

# The logic to get the payment of each person
individual_payment = (total_bill + actual_tip)/no_of_people

# Print the final statement
print(f"The actual tip {tip}% of the total bill is ${actual_tip}.\nEach person should pay: ${individual_payment}")