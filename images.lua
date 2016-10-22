images={}

function images.load()

	--Player
	images.playerDown = love.graphics.newImage("images/player/playerDown.png")
	images.playerDownHiRes = love.graphics.newImage("images/player/playerDownHiRes.png")
	images.playerSideHiRes = love.graphics.newImage("images/player/playerSideHiRes.png")
	images.playerUpHiRes = love.graphics.newImage("images/player/playerUpHiRes.png")
	images.playerDownAnimeA = love.graphics.newImage("images/player/playerDownAnimeA.png")
	images.playerDownAnimeD = love.graphics.newImage("images/player/playerDownAnimeD.png")
	images.playerUp = love.graphics.newImage("images/player/playerUp.png")
	images.playerUpAnimeA = love.graphics.newImage("images/player/playerUpAnimeA.png")
	images.playerUpAnimeD = love.graphics.newImage("images/player/playerUpAnimeD.png")
	images.playerSide = love.graphics.newImage("images/player/playerSide.png")

	--Inventory
	images.hotbar = love.graphics.newImage("images/player/hotbar.png")
end

function UPDATE_IMAGES(dt)

	images.update()

end