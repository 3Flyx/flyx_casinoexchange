RegisterNetEvent('flyx_casinoexchange/buyChips', function(data)
    local chipCount = data.chipCount
    local price = chipCount * Config.ChipPrice
    if exports.ox_inventory:GetItemCount(source, 'money') < price then return end

    if not exports.ox_inventory:RemoveItem(source, 'money', price) then 
        lib.print.warn("There was an error with removing money from "..source)
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"),
            description = locale("error_removing_money")
        })
    end

    exports.ox_inventory:AddItem(source, Config.ChipItem, chipCount)
end)

RegisterNetEvent('flyx_casinoexchange/sellChips', function(data)
    local chipCount = data.chipCount
    if exports.ox_inventory:GetItemCount(source, Config.ChipItem) < chipCount then return end

    if not exports.ox_inventory:RemoveItem(source, Config.ChipItem, chipCount) then 
        lib.print.warn("There was an error with removing Chips from "..source)
        TriggerClientEvent('ox_lib:notify', source, {
            title = locale("notify_title"),
            description = locale("error_removing_chips")
        })
    end

    exports.ox_inventory:AddItem(source, 'money', chipCount*Config.ChipPrice)
end)