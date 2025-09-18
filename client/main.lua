CreateThread(function()
    local npc
    local ped = Config.Ped
    
    lib.requestModel(ped.model, 10000)

    npc = CreatePed(4, ped.model, ped.coords.x, ped.coords.y, ped.coords.z-1, ped.coords.w, false, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    FreezeEntityPosition(npc, true)

    if ped.scenario then
        TaskStartScenarioInPlace(npc, ped.scenario, 0, true)
    end

    if ped.blip then
        local blip = AddBlipForCoord(ped.coords.x, ped.coords.y, ped.coords.z)
        SetBlipSprite(blip, ped.blip.sprite)
        SetBlipColour(blip, ped.blip.color)
        SetBlipScale(blip, ped.blip.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(ped.blip.label)
        EndTextCommandSetBlipName(blip)
    end

    exports.ox_target:addLocalEntity(npc, {
        name = "flyx_casinoexchange/npc",
        icon = "fa-solid fa-diamond",
        label = locale('target_label'),
        onSelect = function()
            OpenMenu()
        end
    })
end)

function OpenMenu()
    local contextOptions = {}
    lib.registerContext({
        id = 'casino_menu',
        title = locale('main_title'),
        options = {
            {
                title = locale('buy_chips'),
                description = locale('buy_chips_desc'),
                icon = 'hand',
                onSelect = function()
                    local input = lib.inputDialog(locale('buy_title'), {
                        {type = 'number', label = locale('buy_number_title'), description = locale('buy_number_desc'), required = true, min = 1, max = Config.ChipBuying.maxChips}
                    })
                    if not input[1] then return end
                    if exports.ox_inventory:GetItemCount('money') < input[1] * Config.ChipPrice then 
                        return lib.notify({
                            title = locale('notify_title'),
                            description = locale('not_enough_money'),
                            type = 'error'
                        })
                        end
                    TriggerServerEvent('flyx_casinoexchange/buyChips', {chipCount = input[1]})
                end
            },
        }
    })

    local chipCount = exports.ox_inventory:GetItemCount(Config.ChipItem)
    if chipCount > 0 then
        contextOptions[#contextOptions+1] = {
            {
                title = locale('sell_chips'),
                description = locale('sell_chips_desc'),
                icon = 'hand',
                onSelect = function()
                    local input = lib.inputDialog(locale('sell_title'), {
                        {type = 'number', label = locale('sell_number_title'), description = locale('sell_number_desc'), required = true, min = 1, max = Config.ChipBuying.maxChips}
                    })
                    if not input[1] then return end

                    if input[1] > chipCount then 
                        return lib.notify({
                            title = locale('notify_title'),
                            description = locale('not_enough_chips'),
                            type = 'error'
                        })
                    end
                    TriggerServerEvent('flyx_casinoexchange/sellChips', false, {chipCount = input[1]})
                end
            },
        }
    end
end