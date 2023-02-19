local function execurl(url)
    loadstring(game:HttpGet(url))()
end

if game.PlaceId == 189707 then
    execurl("https://raw.githubusercontent.com/rksssgthjuk7j66h/AntixHub/main/NaturalDisaster%20Survival.lua")
elseif game.PlaceId == 286090429 then
    execurl("https://raw.githubusercontent.com/rksssgthjuk7j66h/AntixHub/main/Arsenal.lua")
elseif game.PlaceId == 1345139196 then
    execurl("https://raw.githubusercontent.com/rksssgthjuk7j66h/AntixHub/main/TreasureHuntSimulator.lua")
elseif game.PlaceId == 6516141723 or game.PlaceId == 6839171747 then
    execurl("https://raw.githubusercontent.com/rksssgthjuk7j66h/AntixHub/main/Doors.lua")
else
    game.Players.LocalPlayer.Kick(game.Players.LocalPlayer, "Wrong game")
    game.Players.LocalPlayer:Kick("Wrong game")
end
