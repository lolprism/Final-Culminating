local function celsiusToFahrenheit(c)
    return (c * 9/5) + 32
end

local function celsiusToKelvin(c)
    return c + 273.15
end

local function fahrenheitToCelsius(f)
    return (f - 32) * 5/9
end

local function fahrenheitToKelvin(f)
    return (f - 32) * 5/9 + 273.15
end

local function kelvinToCelsius(k)
    return k - 273.15
end

local function kelvinToFahrenheit(k)
    return (k - 273.15) * 9/5 + 32
end

print("Temperature Converter")
print("1. Celsius to Fahrenheit")
print("2. Celsius to Kelvin")
print("3. Fahrenheit to Celsius")
print("4. Fahrenheit to Kelvin")
print("5. Kelvin to Celsius")
print("6. Kelvin to Fahrenheit")

print("Enter your choice (1-6):")
local choice = tonumber(io.read())

print("Enter the temperature:")
local temp = tonumber(io.read())

if choice == 1 then
    print("Result: " .. celsiusToFahrenheit(temp))
elseif choice == 2 then
    print("Result: " .. celsiusToKelvin(temp))
elseif choice == 3 then
    print("Result: " .. fahrenheitToCelsius(temp))
elseif choice == 4 then
    print("Result: " .. fahrenheitToKelvin(temp))
elseif choice == 5 then
    print("Result: " .. kelvinToCelsius(temp))
elseif choice == 6 then
    print("Result: " .. kelvinToFahrenheit(temp))
else
    print("Invalid choice.")
end