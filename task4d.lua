print("Enter a word:")
local word = string.lower(io.read())

if word == string.reverse(word) then
    print("Palindrome")
else
    print("Not a palindrome")
end