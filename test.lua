-- Konfiguration
local menu = {
    { name = "Burger", price = 5 },
    { name = "Pommes", price = 3 },
    { name = "Cola", price = 2 },
}

-- Funktion zur Anzeige des Menüs in der Computerkonsole
function displayMenuInConsole()
    print("Willkommen bei McComputerCraft!")
    
    for i, item in ipairs(menu) do
        print(i .. ") " .. item.name .. ": $" .. item.price)
    end
    
    print("Geben Sie die Bestellnummer ein:")
end

-- Funktion zur Bestellabwicklung
function takeOrder()
    local orderComplete = false
    local totalCost = 0
    local customerOrder = {}
    
    while not orderComplete do
        displayMenuInConsole()
        local choice = tonumber(read())
        
        if choice and choice >= 1 and choice <= #menu then
            local selectedItem = menu[choice]
            table.insert(customerOrder, selectedItem)
            totalCost = totalCost + selectedItem.price
        elseif choice == 0 then
            orderComplete = true
        else
            -- Reagiere auf ungültige Eingabe
            print("Ungültige Eingabe. Bitte erneut eingeben.")
            sleep(2)  -- 2 Sekunden warten, um die Nachricht anzuzeigen
        end
    end

    -- Ausgabe der Bestellung in der Computerkonsole
    print("Vielen Dank für Ihre Bestellung!")

    for i, item in ipairs(customerOrder) do
        print(item.name .. ": $" .. item.price)
    end

    print("Gesamtpreis: $" .. totalCost)
    sleep(5) -- Warte 5 Sekunden, bevor die Konsole gelöscht wird
    term.clear()
    term.setCursorPos(1,1)
end

-- Hauptprogramm
while true do
    displayMenuInConsole()
    takeOrder()
end
