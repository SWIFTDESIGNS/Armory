_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Armory", "Protect & Serve!")
_menuPool:Add(mainMenu)
_menuPool:MouseControlsEnabled (false)
_menuPool:MouseEdgeEnabled (false)
_menuPool:ControlDisablingEnabled(false)

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

function giveWeapon(weaponHash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(weaponHash), 999, false, false --[[equips when gotten]])
end

function weaponComponent(weaponHash, component)
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(weaponHash), false) then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weaponHash), GetHashKey(component))
     end
end

function Leo(menu)
   local click = NativeUI.CreateItem("Loadout", "Collect your standard issued weapons")
   menu:AddItem(click)
   menu.OnItemSelect = function(sender,item,index)
    if item == click then
        giveWeapon("weapon_CombatPistol")
        weaponComponent("weapon_CombatPistol","COMPONENT_AT_PI_FLSH")
        giveWeapon("weapon_CarbineRifle")
        weaponComponent("weapon_CarbineRifle","COMPONENT_AT_AR_FLSH")
        giveWeapon("weapon_Flashlight")
        giveWeapon("weapon_StunGun")
        giveWeapon("weapon_PumpShotgun")
        weaponComponent("weapon_PumpShotgun","COMPONENT_AT_AR_FLSH")
        ShowNotification("You have collected your Duty weapons")
    end
   end
end
Leo(mainMenu)
_menuPool:RefreshIndex()

local ped = GetPlayerPed(player) 
local pos = GetEntityCoords(ped, true) 

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
       _menuPool:ProcessMenus()
        if IsControlJustPressed(1,38) then
            mainMenu:Visible(not mainMenu:Visible())
         end
    end
end)


