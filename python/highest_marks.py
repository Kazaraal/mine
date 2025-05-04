# highest_marks.py prints the highest marks of the students' scores.

student_scores = [150, 142, 185, 120, 171, 184, 149, 24, 59, 68, 199, 78, 65, 89, 86, 55, 91, 64, 89]

maximum = 0

for score in student_scores:
    if score > maximum:
        maximum = score

print(maximum)