local inventory = {
    apple = 10,
    banana = 5,
    sword = 1
}

print("Enter an item:")
local item = string.lower(io.read())

if inventory[item] then
    print(item .. " is available.")
    print("Quantity: " .. inventory[item])
else
    print(item .. " is not available.")
end