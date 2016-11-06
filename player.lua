player={}
require"images"

function player.load()

	playerSpeed = 0.002 --0.002
	playerSpeedDiagonal = 0.001 -- 0.001
    playerSprint = 2
    playerDefaultSpeed = 0.002
    playerDefaultSpeedDiagonal = 0.001
	doOnce = true
	playerSizeX = 2
	playerSizeY = 2
	playerScreenX = 560
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

    weaponXOffset = 43
    weaponYOffset = 10
    weaponRotation = 0
    weaponXSize = 2
    currentWeapon = images.woodenSword

    maxStamina = 100
    stamina = 100
    staminaRegen = 0.05

    maxHealth = 100
    health = 100
    healthRegen = 0.01

    maxMana = 0
    mana = 0
    manaRegen = 0.05

    maxHunger = 100
    hunger = 100
    hungerRegen = 0.05

    alive = true

end

function player.update(dt)

    if health < maxHealth then
        health = health + healthRegen
    end

    if mana < maxMana then
        mana = mana + manaRegen
    end

    if love.mouse.isDown(1) and inmenu == false then
        weaponRotation = weaponRotation + 0.09817477
    elseif inmenu == false then
        weaponRotation = 0
    end

    if love.keyboard.isDown("a")then
	    animeDelayA = animeDelayA - dt
        a = true
        d = false
        s = false
        w = false
    elseif love.keyboard.isDown("d")then
        animeDelayD = animeDelayD - dt
        a = false
        d = true
        s = false
        w = false
    elseif love.keyboard.isDown("w")then
        animeDelayW = animeDelayW - dt
        a = false
        d = false
        s = false
        w = true
    elseif love.keyboard.isDown("s")then
        animeDelayS = animeDelayS - dt
        a = false
        d = false
        s = true
        w = false
    end

    if a == true then weaponXOffset = -20
    weaponXSize = 2 end
    if d == true then weaponXOffset = 43 end
    if s == true then weaponXOffset = 43 end
    if w == true then weaponXOffset = 43 end

end

function player.draw()

	if doOnce == true then
		playerImage = images.playerDown
		doOnce = false
	end

    if inmenu == false then

        if love.keyboard.isDown("w") and alternateW == true then
            playerImage = images.playerUpAnimeA
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayW <= 0 then
                alternateW = false
                animeDelayW = 0.4
            end
        elseif love.keyboard.isDown("w") and alternateW == false then
            playerImage = images.playerUpAnimeD
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayW <= 0 then
                alternateW = true
                animeDelayW = 0.4
            end
        end

        if love.keyboard.isDown("s") and alternateS == true then
            playerImage = images.playerDownAnimeA
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayS <= 0 then
                alternateS = false
                animeDelayS = 0.4
            end
        elseif love.keyboard.isDown("s") and alternateS == false then
            playerImage = images.playerDownAnimeD
            playerSizeX = 2
            playerScreenX = 560
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
            playerScreenX = 560
            if animeDelayD <= 0 then
                alternateD = false
                animeDelayD = 0.4
            end
        elseif love.keyboard.isDown("d") and alternateD == false then
            playerImage = images.playerSide
            playerSizeX = 2
            playerScreenX = 560
            if animeDelayD <= 0 then
                alternateD = true
                animeDelayD = 0.4
            end
        end
    end

    if love.keyboard.isDown("w") or love.keyboard.isDown("a") or love.keyboard.isDown("s") or love.keyboard.isDown("d") then
        if currentTile == 7 then
            playerSpeed = 0.0002
            playerSpeedDiagonal = 0.0001
        end
        if love.keyboard.isDown("lctrl") then
            if stamina >= 0.75 then
            	playerSpeed = playerDefaultSpeed*playerSprint
            	playerSpeedDiagonal = playerDefaultSpeedDiagonal*playerSprint
                stamina = stamina - 0.25
            else
                playerSpeed = playerDefaultSpeed
                playerSpeedDiagonal = playerDefaultSpeedDiagonal
            end
        else
            if stamina < maxStamina then
                stamina = stamina + staminaRegen
                playerSpeed = playerDefaultSpeed
                playerSpeedDiagonal = playerDefaultSpeedDiagonal
            end
        end
    end

    if love.keyboard.isDown("lctrl") then elseif stamina < maxStamina then
        stamina = stamina + staminaRegen
        playerSpeed = playerDefaultSpeed
        playerSpeedDiagonal = playerDefaultSpeedDiagonal
    end
    
    function love.keyreleased(releaseImage)
        if releaseImage == "a" or releaseImage == "s" or releaseImage == "d" and inmenu == false then
            playerImage = images.playerDown
            playerSizeX = 2
            playerScreenX = 560
        elseif releaseImage == "w" and inmenu == false then
            playerImage = images.playerUp
            playerSizeX = 2
            playerScreenX = 560
        elseif releaseImage == "escape" then
        	if ingame == true then
        		inmenu = not inmenu
        	end
        end
    end

	love.graphics.draw(playerImage, playerScreenX, playerScreenY, 0, playerSizeX, playerSizeY)
    love.graphics.draw(currentWeapon, playerScreenX+weaponXOffset, playerScreenY+weaponYOffset, weaponRotation, playerSizeX, playerSizeY)

end

function UPDATE_PLAYER(dt)

	player.update(dt)

end

function DRAW_PLAYER()

	player.draw()

end