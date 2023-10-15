-- Konfiguration
local menu = {
    { name = "Burger", price = 5 },
    { name = "Pommes", price = 3 },
    { name = "Cola", price = 2 },
}

local monitor = peripheral.find("monitor")
local printer = peripheral.find("printer")
monitor.setTextScale(0.5)  -- Kleinerer Text

-- Funktion zur Anzeige des Menüs
function displayMenu()
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Willkommen bei McComputerCraft!")
    
    for i, item in ipairs(menu) do
        monitor.setCursorPos(1, i * 2 + 1)
        monitor.write(i .. ") " .. item.name .. ": $" .. item.price)
    end
    
    monitor.setCursorPos(1, #menu * 2 + 3)
    monitor.write("Geben Sie die Bestellnummer ein:")
end

-- Funktion zur Bestellabwicklung
function takeOrder()
    local orderComplete = false
    local totalCost = 0
    local customerOrder = {}
    
    while not orderComplete do
        displayMenu()
        monitor.setCursorPos(1, #menu * 2 + 4)
        local choice = tonumber(read())
        
        if choice and choice >= 1 and choice <= #menu then
            local selectedItem = menu[choice]
            table.insert(customerOrder, selectedItem)
            totalCost = totalCost + selectedItem.price
        elseif choice == 0 then
            orderComplete = true
        else
            -- Reagiere auf ungültige Eingabe
            monitor.setCursorPos(1, #menu * 2 + 5)
            monitor.write("Ungültige Eingabe. Bitte erneut eingeben.")
            sleep(2)  -- 2 Sekunden warten, um die Nachricht anzuzeigen
        end
    end
    
    -- Ausgabe der Bestellung auf den Drucker
    printer.clear()
    printer.setCursorPos(1, 1)
    printer.write("McComputerCraft Bestellung:")
    
    for i, item in ipairs(customerOrder) do
        printer.setCursorPos(1, i + 2)
        printer.write(item.name .. ": $" .. item.price)
    end
    
    printer.setCursorPos(1, #customerOrder + 3)
    printer.write("Gesamtpreis: $" .. totalCost)
    
    monitor.clear()
    monitor.setCursorPos(1, 1)
    monitor.write("Vielen Dank für Ihre Bestellung!")
    
    for i, item in ipairs(customerOrder) do
        monitor.setCursorPos(1, i * 2 + 1)
        monitor.write(item.name .. ": $" .. item.price)
    end
    
    monitor.setCursorPos(1, #menu * 2 + 3)
    monitor.write("Gesamtpreis: $" .. totalCost)
    sleep(5) -- Warte 5 Sekunden, bevor der Bildschirm gelöscht wird
    monitor.clear()
end

-- Hauptprogramm
while true do
    displayMenu()
    takeOrder()
end
