def protus(a, b, operation='+'):
    """
    A function that performs basic arithmetic operations on two numbers.
    
    Parameters:
    a (float): First number
    b (float): Second number
    operation (str): Operation to perform ('+', '-', '*', '/')
    
    Returns:
    float: Result of the operation
    """
    if operation == '+':
        return a + b
    elif operation == '-':
        return a - b
    elif operation == '*':
        return a * b
    elif operation == '/':
        if b == 0:
            raise ValueError("Division by zero is not allowed")
        return a / b
    else:
        raise ValueError("Invalid operation. Use '+', '-', '*', or '/'")

# Example usage of the protus function with random numbers
if __name__ == "__main__":
    import random
    
    print("\nTesting protus function with random numbers (in grams):")
    # Generate random numbers between 1 and 100
    num1 = random.randint(1, 100)
    num2 = random.randint(1, 100)
    operations = ['+', '-', '*', '/']
    
    # Test all operations with random numbers
    for op in operations:
        try:
            result = protus(num1, num2, op)
            print(f"{num1}g {op} {num2}g = {result}g")
        except ValueError as e:
            print(f"Error: {e}") 