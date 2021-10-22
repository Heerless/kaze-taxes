QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

function GetUsersForTax(d, h, m)
    QBCore.Functions.ExecuteSql(true, 'SELECT * FROM players', {}, function(AllUser)
        RunTax(AllUser)
    end)
end

-- Bank Taxing
function BankTax(AllUser)
    local tax = nil 
    for i=1 , #AllUser,1 do 
        if (AllUser[i].bank <= Config.HoboClassLimit) then
            tax = 0
        elseif (AllUser[i].bank < Config.PoorClassLimit) then
            local taxpercent = Config.PoorClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000 
        elseif (AllUser[i].bank < Config.LowerClassLimit) then
            local taxpercent = Config.LowerClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000 
        elseif (AllUser[i].bank < Config.LowerMiddleClassLimit) then
            local taxpercent = Config.LowerMiddleClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000 
        elseif (AllUser[i].bank < Config.MiddleClassLimit) then
            local taxpercent = Config.MiddleClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        elseif (AllUser[i].bank < Config.UpperMiddleClassLimit) then
            local taxpercent = Config.UpperMiddleClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        elseif (AllUser[i].bank < Config.LowerHigherClassLimit) then
            local taxpercent = Config.LowerHigherClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        elseif  (AllUser[i].bank < Config.HigherClassLimit) then
            local taxpercent = Config.HigherClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        else -- Higher Class 
            local taxpercent = Config.UpperHigherClassTax 
            tax = (AllUser[i].bank*taxpercent) / 1000
        end
        local Player = QBCore.Functions.GetPlayerByCitizenId(AllUser[i].identifier)
        if(Player ~= nil) then 
            if tax ~= 0 then                 
                Player.Functions.RemoveMoney("bank", tax, "paid-taxes")
                TriggerClientEvent('QBCore:Notify', source, "You paid your bank taxes | $"..tax)
            end         
        end
    end 
end

-- Car Taxing
function CarsTax(AllUser)     
    QBCore.Functions.ExecuteSql(true, 'SELECT * FROM player_vehicles',{}, function(AllCars)
        local taxMultiplier = Config.CarTax
        for i=1 , #AllUser,1 do 
            local carCount = 0

            for a=1 , #AllCars,1 do 
                if AllUser[i].identifier == AllCars[a].owner and (AllCars[a].job ~= 'police' and AllCars[a].job ~= 'ambulance') then
                    carCount = carCount + 1
                end
            end

            if carCount > 0 then
                local tax = carCount * taxMultiplier
                local Player = QBCore.Functions.GetPlayerByCitizenId(AllUser[i].identifier)
                if (Player ~= nil) then
                    Player.Functions.RemoveMoney("bank", tax, "paid-car-taxes")
                    TriggerClientEvent('QBCore:Notify', source, "You paid your car taxes | $"..tax)
                end
            end

            QBCore.Functions.ExecuteSql(false, "SELECT `vehicle` FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
                if result[1] ~= nil then
                    vehcategory = QBCore.Shared.Vehicles[vehicleData["category"]]
                    local extracategorytax = 0
                    if vehcategory == 'super' then
                        extracategorytax = Config.CarTaxSuper
                        Player.Functions.RemoveMoney("bank", extracategorytax, "paid-car-taxes")
                        TriggerClientEvent('QBCore:Notify', source, "Because you have a Super car you paid extra taxes | $"..extracategorytax)
                    elseif vehcategory == 'sport' then
                        extracategorytax = Config.CarTaxSport
                        Player.Functions.RemoveMoney("bank", extracategorytax, "paid-car-taxes")
                        TriggerClientEvent('QBCore:Notify', source, "Because you have a Sport car you paid extra taxes | $"..extracategorytax)
                    elseif vehcategory == 'suv' then
                        extracategorytax = Config.CarTaxSuv
                        Player.Functions.RemoveMoney("bank", extracategorytax, "paid-car-taxes")
                        TriggerClientEvent('QBCore:Notify', source, "Because you have a Suv car you paid extra taxes | $"..extracategorytax)
                    elseif vehcategory == 'tuner' then
                        extracategorytax = Config.CarTaxTuner
                        Player.Functions.RemoveMoney("bank", extracategorytax, "paid-car-taxes")
                        TriggerClientEvent('QBCore:Notify', source, "Because you have a Tuner car you paid extra taxes | $"..extracategorytax)
                    else
                        TriggerClientEvent('QBCore:Notify', source, "No extra car taxes")
                    end
                end
            end)
        end
    end)
end

function RunTax(AllUser)
    BankTax(AllUser)
    CarsTax(AllUser)
    Wait(Config.TaxInterval)
    GetUsersForTax()
end

GetUsersForTax()