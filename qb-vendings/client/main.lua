

RegisterNetEvent("qb-vendings:client:open:vending")
AddEventHandler("qb-vendings:client:open:vending", function(Data)
    local Category = Data['category']
    local ShopItems = {}
    ShopItems['label'] = Config.VendingMachines[Category]['Label']
    ShopItems['items'] = Config.VendingMachines[Category]['Items']
    ShopItems['slots'] = #Config.VendingMachines[Category]['Items']
    TriggerServerEvent("inventory:server:OpenInventory", "shop", Config.VendingMachines[Category]['Label'].."_"..math.random(1, 99), ShopItems)
end)

-- // Create Vendings (qb-target required) // --

Citizen.CreateThread(function()
    for k, v in pairs(Config.Vendings) do
        exports['qb-target']:AddTargetModel(GetHashKey(v['Model']), {
            options = {
                {
                    type = "client",
                    event = "qb-vendings:client:open:vending",
                    icon = v['Icon'],
                    label = v['Label'],
                    category = v['Category'],
                },
            },
            distance = 2.5
        })
    end
    print('[VENDINGS] '..#Config.Vendings..' Vendings created successfully.')
end)

-- AwayFromKane (#0001)