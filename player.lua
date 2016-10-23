player={}
require "images"

function player.load()

	playerDefaultSpeed = 0.002
	playerDefaultSpeedDiagonal = 0.001
    playerSprint = 2.5

    playerSpeed = 1
    playerSpeedDiagonal = 1

	doOnce = true
	playerSizeX = 2
	playerSizeY = 2
	playerScreenX = 550
	playerScreenY = 350

    animeDelayW = 0.1
    animeDelayA = 0.1
    animeDelayS = 0.1
    animeDelayD = 0.1

    alternateW = true
    alternateA = true
    alternateS = true
    alternateD = true

    playerX = 1
    playerY = 1
    currentBiome = 1
    currentTile = 1

    maxHealth = 100
    health = 100
    alive = true

end

function player.update(dt)

    if love.keyboard.isDown("a")then
	    animeDelayA = animeDelayA - dt
    elseif love.keyboard.isDown("d")then
        animeDelayD = animeDelayD - dt
    elseif love.keyboard.isDown("w")then
        animeDelayW = animeDelayW - dt
    elseif love.keyboard.isDown("s")then
        animeDelayS = animeDelayS - dt
    end

end

function player.draw()

    if health < 1 then
        alive = false
        love.graphics.setColor(255, 0, 0)
        love.graphics.print("You died", 330, 300, 0, 10, 10)
        love.graphics.setBackgroundColor(50, 50, 50)
    end

	if doOnce == true then
		playerImage = images.playerDown
		doOnce = false
	end

    if inmenu == false and alive == true then

        if love.keyboard.isDown("w") and alternateW == true then
            playerImage = images.playerUpAnimeA
            playerSizeX = 2
            playerScreenX = 550
            if animeDelayW <= 0 then
                alternateW = false
                animeDelayW = 0.4
            end
        elseif love.keyboard.isDown("w") and alternateW == false then
            playerImage = images.playerUpAnimeD
            playerSizeX = 2
            playerScreenX = 550
            if animeDelayW <= 0 then
                alternateW = true
                animeDelayW = 0.4
            end
        end

        if love.keyboard.isDown("s") and alternateS == true then
            playerImage = images.playerDownAnimeA
            playerSizeX = 2
            playerScreenX = 550
            if animeDelayS <= 0 then
                alternateS = false
                animeDelayS = 0.4
            end
        elseif love.keyboard.isDown("s") and alternateS == false then
            playerImage = images.playerDownAnimeD
            playerSizeX = 2
            playerScreenX = 550
            if animeDelayS <= 0 then
                alternateS = true
                animeDelayS = 0.4
            end
        end

        if love.keyboard.isDown("a") and alternateA == true then
            playerImage = images.playerDownAnimeD
            playerSizeX = -2
            playerScreenX = 625
            if animeDelayA <= 0 then
                alternateA = false
                animeDelayA = 0.4
            end
        elseif love.keyboard.isDown("a") and alternateA == false then
            playerImage = images.playerSide
            playerSizeX = -2
            playerScreenX = 625
            if animeDelayA <= 0 then
                alternateA = true
                animeDelayA = 0.4
            end
        end

        if love.keyboard.isDown("d") and alternateD == true then
            playerImage = images.playerDownAnimeD
            playerSizeX = 2
            playerScreenX = 550
            if animeDelayD <= 0 then
                alternateD = false
                animeDelayD = 0.4
            end
        elseif love.keyboard.isDown("d") and alternateD == false then
            playerImage = images.playerSide
            playerSizeX = 2
            playerScreenX = 550
            if animeDelayD <= 0 then
                alternateD = true
                animeDelayD = 0.4
            end
        end
    end

    if love.keyboard.isDown("lctrl") then
    	playerSpeed = playerDefaultSpeed*playerSprint
    	playerSpeedDiagonal = playerDefaultSpeedDiagonal*playerSprint
        if currentTile == 7 then
            playerSpeed = 0
            playerSpeedDiagonal = 0
        end
        health = health - 0.1
    else
    	playerSpeed = playerDefaultSpeed
    	playerSpeedDiagonal = playerDefaultSpeedDiagonal
        if currentTile == 7 then
            playerSpeed = 0
            playerSpeedDiagonal = 0
        end
    end

    function love.keyreleased(releaseImage)
        if releaseImage == "a" or releaseImage == "s" or releaseImage == "d" and inmenu == false and alive == true then
            playerImage = images.playerDown
            playerSizeX = 2
            playerScreenX = 550
        elseif releaseImage == "w" and inmenu == false and alive == true then
            playerImage = images.playerUp
            playerSizeX = 2
            playerScreenX = 550
        elseif releaseImage == "escape" then
        	inmenu = not inmenu
            options = false
        end
    end

    if alive == true then

    love.graphics.draw(playerImage, playerScreenX, playerScreenY, 0, playerSizeX, playerSizeY)            
    love.graphics.print((math.floor(health)).."/"..maxHealth, 10, 660)
end
end

function UPDATE_PLAYER(dt)

	player.update(dt)

end

function DRAW_PLAYER()

	player.draw()

end