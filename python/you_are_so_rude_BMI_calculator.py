# BMI calculator

weight = float(input("Please provide your weight.\n"))
height = float(input("Please provide your height.\n"))

bmi = weight / (height ** 2)

if bmi < 18.5:
    print("You are underweight.")
elif bmi < 24.9:
    print("You are normal weight.")
else:
    print("You are overweight.")