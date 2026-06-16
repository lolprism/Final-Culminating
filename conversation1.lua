local function most_common_vowel(input)
    local vowels = { a = 0, e = 0, i = 0, o = 0, u = 0 }
    
    input = input:lower()
    
    for char in input:gmatch(".") do
        if vowels[char] ~= nil then
            vowels[char] = vowels[char] + 1
        end
    end

    local max_vowel, max_count = nil, 0
    for vowel, count in pairs(vowels) do
        if count > max_count then
            max_vowel, max_count = vowel, count
        end
    end

    return max_vowel
end

io.write("Enter a String: ")
local user_input = io.read()

local result = most_common_vowel(user_input)
print("The most common vowel is: " .. result)

-- I need to take user input and then loop through each charracter in the words they input and then count the most common number of times a vowel appeaers