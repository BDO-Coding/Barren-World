hotbar={}
require "player"
require "images"

function hotbar.load()

	currentHotbarHand = 1
	hotbarXCoord = 500
	barLength = 4
	barHeight = 2

	leftX = 155
	rightX = 385

	healthX = 10
	staminaX = 0
	manaX = 0
	hungerX = 20

	selectedSlot = 1

	slotAmount = 10

	hotbarArray = {{}}
	hotbar.reload()

	highestUsedSpot=0
	throw1 = false

	works = false
	--[[Example hotbar :
		1=HotbarNumber,
		true=If it is selected or not,
		1=The ID of the item in it,
		1=The number of items in it
	]]

end

function hotbar.reload()

	for i = 1,slotAmount do
		hotbarArray[i] = {i,false,1,0}
		if numberKey == i then
			hotbarArray[i][2] = true
		end
	end

end

function love.wheelmoved(x, y)

    if y > 0 then
        selectedSlot = selectedSlot - 1
    elseif y < 0 then
        selectedSlot = selectedSlot + 1
    end

end

function hotbar.throw()

	if love.keyboard.isDown("q") then
		throw1 = true
	else
		if throw1 == true then
					if hotbarArray[selectedSlot][4] > 0 then
						item.throw(hotbar.round(playerX, 0), hotbar.round(playerY-0.5, 0),hotbarArray[selectedSlot][3])
						hotbarArray[selectedSlot][4] = hotbarArray[selectedSlot][4] - 2
						throw1=false
					end
		end
	end
end

function hotbar.take(id,amount)
	amount = amount / 2
	for i = 1, slotAmount do
		if hotbarArray[i][3] == id then
			if hotbarArray[i][4] > amount then
				hotbarArray[i][4] = hotbarArray[i][3] - amount
					return true
			else
				if hotbarArray[i][4] == amount then
					hotbarArray[i][4] = 0
					hotbarArray[i][3] = 0
					return true
				else
					return false
				end
			end
		end
	end
					return false
end

function hotbar.update(dt)
	hotbar.throw()
	if selectedSlot > slotAmount then
		selectedSlot = 1
	end

	if selectedSlot < 1 then
		selectedSlot = slotAmount
	end

	if love.keyboard.isDown("e") then
		--if hotbarArray[selectedSlot][4] == 0 then
			item.grab(hotbar.round(playerX, 0), hotbar.round(playerY-0.5, 0))
		--end
	end



	healthLength = (health/maxHealth)*barLength
	staminaLength = (stamina/maxStamina)*barLength
	manaLength = (mana/maxMana)*barLength
	hungerLength = (hunger/maxHunger)*barLength

	if health <= 0 then healthLength = 0 end

	if stamina <= 0 then
		staminaLength = 0
		stamina = 0
	end

	if mana <= 0 then manaLength = 0 end

	if hunger <= 0 then hungerLength = 0 end

	if ingame == true and loadScreen == false then
		for i = 1, slotAmount do
			if selectedSlot == i then
				hotbarArray[i][2] = true
			else hotbarArray[i][2] = false end

			if love.keyboard.isDown(i) then
				selectedSlot = i
			end
		end
	end

end

function hotbar.round(num, idp)

	local mult = 10^(idp or 0)
	return math.floor(num * mult + 0.5) / mult
	
end

function hotbar.search(id,amount)
	for i=1,slotAmount do
		if hotbarArray[i][3] == id then
			if hotbarArray[i][4] > (amount*2)-1 then
				return true			
			end		
		end
	end
end

function hotbar.draw()
	if works == true then
love.graphics.draw(images.mana,100,100)
	end

	if inventoryMode == true then
		love.graphics.draw(images.handCursor,hotbarXCoord-55, 660, 0, 1.5, 1.5)		
	end

	hotbarXCoord = 500

	if alive == true then
		hotbarXCoord = 500
		for i = 1,slotAmount do
			if hotbarArray[i][2] == true then
				if hotbarArray[i][4]>0 then
					love.graphics.print(item.getItemName(hotbarArray[i][3]), hotbarXCoord + 15, 720)
				end
				love.graphics.setColor(50, 50, 50)
			else
				love.graphics.setColor(255, 255, 255) 
			end
			love.graphics.draw(images.hotbar, hotbarXCoord, 650, 0, 2, 2)
			if hotbarArray[i][4]/2 > 1 then
								love.graphics.setColor(255, 255, 255) 
			love.graphics.print(hotbarArray[i][4]/2, hotbarXCoord + 5, 655)
		end
			hotbarXCoord = hotbarXCoord + 67
			if hotbarArray[i][4]>0 then
				love.graphics.setColor(255, 255, 255) 
				love.graphics.draw(item.getItemImage(hotbarArray[i][3]), hotbarXCoord-55, 660, 0, 1.5, 1.5)			
			end
		end

	end
	love.graphics.setColor(255, 0, 0)
	love.graphics.draw(images.guiBarInside, 70, 650, 0, healthLength, barHeight)
	love.graphics.setColor(10, 255, 10)
	love.graphics.draw(images.guiBarInside, 70, 680, 0, staminaLength, barHeight)
	love.graphics.setColor(147, 49, 245)
	love.graphics.draw(images.guiBarInside, 300, 650, 0, manaLength, barHeight)
	love.graphics.setColor(224, 157, 49)
	love.graphics.draw(images.guiBarInside, 300, 680, 0, hungerLength, barHeight)
	love.graphics.setColor(255, 255, 255)
	love.graphics.draw(images.guiBar, 70, 650, 0, barLength, barHeight)
	love.graphics.draw(images.guiBar, 70, 680, 0, barLength, barHeight)
	love.graphics.draw(images.guiBar, 300, 650, 0, barLength, barHeight)
	love.graphics.draw(images.guiBar, 300, 680, 0, barLength, barHeight)
	love.graphics.draw(images.health, 33.6, 650, 0, barHeight, barHeight-(barHeight)*0.1)
	love.graphics.draw(images.stamina, 33.6, 680, 0, barHeight, barHeight-(barHeight)*0.1)
	love.graphics.draw(images.mana, 263.6, 650, 0, barHeight, barHeight-(barHeight)*0.1)
	love.graphics.draw(images.hunger, 263.6, 680, 0, barHeight, barHeight-(barHeight)*0.1)
	love.graphics.print((math.floor(health)).."/"..maxHealth, leftX-healthX, 660)
	love.graphics.print((math.floor(stamina)).."/"..maxStamina, leftX-staminaX, 690)
	love.graphics.print((math.floor(mana)).."/"..maxMana, rightX-manaX, 660)
	love.graphics.print((math.floor(hunger)).."/"..maxHunger, rightX-hungerX, 690)
end

function UPDATE_HOTBAR(dt)

	hotbar.update(dt)

end

function DRAW_HOTBAR()

	hotbar.draw()

end