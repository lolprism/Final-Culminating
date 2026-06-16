local fruits = {"apple", "banana", "orange"}

table.insert(fruits, "grape")

for i, fruit in ipairs(fruits) do
    print(fruit)
end