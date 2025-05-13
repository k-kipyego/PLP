def modify_content(content):
    """
    Modify the file content.
    Example: Convert all text to uppercase.
    """
    return content.upper()

def main():
    input_filename = "file_handling.dox"

    try:
        # Try to open and read from file_handling.dox
        with open(input_filename, "r") as infile:
            content = infile.read()

        # Modify the content
        modified_content = modify_content(content)

        # Write modified content to a new file
        output_filename = "modified_file_handling.dox"
        with open(output_filename, "w") as outfile:
            outfile.write(modified_content)

        print(f"\n🎉 Success! Modified content written to '{output_filename}'.")

    except FileNotFoundError:
        print(f"❌ Error: '{input_filename}' not found. Please ensure the file exists in the directory.")
    except IOError:
        print("❌ Error: An I/O error occurred while reading or writing the file.")
    except Exception as e:
        print(f"❌ An unexpected error occurred: {e}")

if __name__ == "__main__":
    main()
