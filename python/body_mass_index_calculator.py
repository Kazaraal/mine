# BMI Calculator creation
# The body mass index (BMI) is a measure used in medicine to see if someone is underweight or overweight. This is the formula used to calculate it:
# bmi is equal to the person's weight divided by the person's height squared.

height = float(input("What is your height? ")) # In metres
weight = int(input("What is your weight? "))   # In kilograms

bmi = weight/(height ** 2)

print(f"The Body-Mass-Index of a height of {height} metres and a weight of {weight} kilograms is {bmi}.")