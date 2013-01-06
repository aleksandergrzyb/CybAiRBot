local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local storyboard = require("storyboard")
local scene = storyboard.newScene()

-- functions
local hideLogo
local entryMainMenu

local bg
local blerdoLogo
local entryMainMenuTimer
local hideTimer

function scene:createScene(event)
	local group = self.view

	bg = display.newImageRect("img/bg.png", _DW, _DH)
	group:insert(bg)
	bg.x, bg.y = .5*_W, .5*_H

	blerdoLogo = display.newImageRect("img/blerdo_logo.png", 191, 67)
	blerdoLogo.x, blerdoLogo.y = .5*_W, .5*_H
	group:insert(blerdoLogo)
end

function scene:enterScene(event)
	local group = self.view
	hideTimer = timer.performWithDelay(100, hideLogo, 1)
end

function scene:exitScene(event)
	local group = self.view
end

function scene:destroyScene(event)
	local group = self.view

	bg:removeSelf()

	timer.cancel(hideTimer)
	hideTimer = nil

	timer.cancel(entryMainMenuTimer)
	entryMainMenuTimer = nil
end

function hideLogo()
	entryMainMenuTimer = timer.performWithDelay(1000, entryMainMenu, 1)
	blerdoLogo.tween = GTween.new(blerdoLogo, 0.5, {alpha = 0})
end

function entryMainMenu()
	storyboard.gotoScene("mainMenu", "slideDown", 800 )
	--storyboard.gotoScene("contactScene", "slideDown", 8 )
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene
