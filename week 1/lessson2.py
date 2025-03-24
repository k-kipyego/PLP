# Ask the user for two numbers and an operation
num1 = float(input("Enter the first number: "))
num2 = float(input("Enter the second number: "))
operation = input("Enter the operation (+, -, *, /): ")

# Perform the operation based on user input
if operation == "+":
    result = num1 + num2
elif operation == "-":
    result = num1 - num2
elif operation == "*":
    result = num1 * num2
elif operation == "/":
    # Check to avoid division by zero
    if num2 != 0:
        result = num1 / num2
    else:
        print("Error: Division by zero is not allowed.")
        exit()
else:
    print("Error: Invalid operation entered.")
    exit()

# Display the result in the format: num1 operation num2 = result
print(f"{num1} {operation} {num2} = {result}")
