def calculate_discount(price, discount_percent):
    """
    Calculates the final price after applying discount.
    Applies discount only if discount_percent >= 20.
    """
    if discount_percent >= 20:
        discount_amount = price * (discount_percent / 100)
        return price - discount_amount
    else:
        return price

# Get input from the user
try:
    price = float(input("Enter the original price: "))
    discount_percent = float(input("Enter the discount percentage: "))

    final_price = calculate_discount(price, discount_percent)

    # Display result
    if discount_percent >= 20:
        print(f"Discount applied! Final price: Ksh{final_price:.2f}")
    else:
        print(f"No discount applied. Final price: Ksh{final_price:.2f}")
except ValueError:
    print("Please enter valid numbers for price and discount percentage.")
