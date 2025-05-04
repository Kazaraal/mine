# password_generator.py generates a password with letters, symbols and numbers.

import random

letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

numbers = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]

symbols = ["1", "#", "$", "%","&", "(", ")", "*", "+"]

no_letters = int(input("How many letters do you want in your password?\n"))

no_numbers = int(input("How many numbers do you want in your password?\n"))

no_symbols = int(input("How many symbols do you want in your password?\n"))

password = ""

for char in range(0, no_letters):
    random_char = random.choice(letters)
    password += random_char

for num in range(0, no_numbers):
    random_num = random.choice(numbers)
    password += random_num

for sym in range(0, no_symbols):
    random_sym = random.choice(symbols)
    password += random_sym

print(f"\nThe unshuffled password is {password}")

final_password = random.sample(password, len(password))

print(f"\nThe password in a list is {final_password}")

final_final_password = ""

final_final_password = "".join(final_password)

print(f"\nThe password generated is {final_final_password}")