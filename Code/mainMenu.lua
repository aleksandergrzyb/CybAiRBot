local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local setTimer = timer.performWithDelay
local clearTimer = timer.cancel

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()


local bg
local logoCybAiR
local lineBottom
local lineTop
local newsButton
local mapButton
local scheduleButton
local contactButton
local partnersButton
local descriptionButton

function scene:createScene(event)
	local group = self.view

	bg = display.newImageRect("img/bg.png", _DW, _DH)
	group:insert(bg)
	bg.x, bg.y = .5*_W, .5*_H

	lineTop = display.newImageRect("img/main/line_top.png", 320, 4)
	lineTop.x = _W * 0.5
	lineTop.y = 200
	group:insert(lineTop)

	lineBottom = display.newImageRect("img/main/line_top.png", 320, 4)
	lineBottom.x = _W * 0.5
	lineBottom.y = 330
	group:insert(lineBottom)


	logoCybAiR = display.newImageRect("img/main/ludek_logo.png", 320, 195)
	group:insert(logoCybAiR)
	logoCybAiR.x = _W * 0.5
	logoCybAiR.y = 100


	newsButton = BlerdoButton.newAdvBtn({normal = "img/main/icon_news.png", over = "img/main/icon_news_touch.png", normalWidth=106, normalHeight=120})
	group:insert(newsButton)
	newsButton.x = 10
	newsButton.y = 200

	mapButton = BlerdoButton.newAdvBtn({normal = "img/main/icon_map.png", over = "img/main/icon_map_touch.png", normalWidth=106, normalHeight=120})
	group:insert(mapButton)
	mapButton.x = _W * 0.5 - 53
	mapButton.y = 200

	descriptionButton = BlerdoButton.newAdvBtn({normal = "img/main/icon_description.png", over = "img/main/icon_description_touch.png", normalWidth=106, normalHeight=120})
	group:insert(descriptionButton)
	descriptionButton.x = 200
	descriptionButton.y = 200

	scheduleButton = BlerdoButton.newAdvBtn({normal = "img/main/icon_agenda.png", over = "img/main/icon_agenda_touch.png", normalWidth=106, normalHeight=120})
	group:insert(scheduleButton)
	scheduleButton.x = 10
	scheduleButton.y = 330

	partnersButton = BlerdoButton.newAdvBtn({normal = "img/main/icon_support.png", over = "img/main/icon_support_touch.png", normalWidth=106, normalHeight=120})
	group:insert(partnersButton)
	partnersButton.x = _W * 0.5 - 53
	partnersButton.y = 330

	contactButton = BlerdoButton.newAdvBtn({normal = "img/main/icon_contact.png", over = "img/main/icon_contact_touch.png", normalWidth=106, normalHeight=120})
	group:insert(contactButton)
	contactButton.x = 200
	contactButton.y = 330
end

function scene:enterScene(event)
	local group = self.view

	newsButton._onRelease = function()
			storyboard.gotoScene("newsScene", "slideLeft", 400)
		end
	mapButton._onRelease = function()
			storyboard.gotoScene("mapScene", "slideLeft", 400)
		end
	descriptionButton._onRelease = function()
			storyboard.gotoScene("descripionScene", "slideLeft", 400)
		end
	scheduleButton._onRelease = function()
			storyboard.gotoScene("scheduleScene", "slideLeft", 400)
		end
	partnersButton._onRelease = function()
			storyboard.gotoScene("partnersScene", "slideLeft", 400)
		end
	contactButton._onRelease = function()
			storyboard.gotoScene("contactScene", "slideLeft", 400)
		end
end

function scene:exitScene(event)
	local group = self.view

	newsButton._onRelease = nil
	mapButton._onRelease = nil
	descriptionButton._onRelease = nil
	scheduleButton._onRelease = nil
	partnersButton._onRelease = nil
	contactButton._onRelease = nil
end

function scene:destroyScene(event)
	local group = self.view
	bg:removeSelf()
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene
