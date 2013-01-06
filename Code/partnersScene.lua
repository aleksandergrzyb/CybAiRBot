local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"


local storyboard = require("storyboard")
local scene = storyboard.newScene()

local scrollView
local scrollViewy0

local bg
local backButton
local onRectTouch

local title1
local title2
local title3

local picture1
local picture2
local picture3
local picture4
local picture5
local picture6
local picture7
local picture8
local picture9
local picture10
local picture11
local picture12
local picture13
local picture14
local picture15

local topBg
local lineTop

local start = 0
local move = 0

function scene:createScene(event)
	local group = self.view

	bg = display.newImageRect("img/bg.png", _DW, _DH)
	group:insert(bg)
	bg.x, bg.y = .5*_W, .5*_H

	scrollView= display.newGroup()
	group:insert(scrollView)

	topBg = display.newImageRect("img/top_bg.png", _DW, 100)
	group:insert(topBg)
	topBg:setReferencePoint(display.TopCenterReferencePoint)
	topBg.x, topBg.y = .5*_W, display.screenOriginY-30

	lineTop = display.newImageRect("img/main/line_top.png", 320, 4)
	lineTop.x = _W * 0.5
	lineTop.y = topBg.y + 90
	group:insert(lineTop)

	backButton = BlerdoButton.newAdvBtn({normal = "img/back.png", over = "img/back_touch.png", normalWidth=100, normalHeight=80})
	group:insert(backButton)
	backButton.x, backButton.y = display.screenOriginX -5, display.screenOriginY -5

	rect = display.newRect(0,0,_W,_H)
	rect.touch = onRectTouch
	rect:addEventListener("touch",rect)
	rect.alpha = 0.01

	title1 = display.newText("Sponsorzy:", 0, 65, 105, 30, "HelveticaNeue", 20)
	title1:setReferencePoint(display.CenterReferencePoint)
	title1:setTextColor(166,42,42)
	title1.x = _W * 0.5
	scrollView:insert(title1)

	picture1 = display.newImageRect("content/VW.jpg", 150, 130)
	picture1.x = _W * 0.5
	picture1.y = 170
	scrollView:insert(picture1)

	picture2 = display.newImageRect("content/farnell.jpg", 150, 26)
	picture2.x = _W * 0.5
	picture2.y = 265
	scrollView:insert(picture2)

	picture3 = display.newImageRect("content/elektronika.png", 150, 45)
	picture3.x = _W * 0.5
	picture3.y = 320
	scrollView:insert(picture3)

	picture4 = display.newImageRect("content/and_tech.png", 150, 61)
	picture4.x = _W * 0.5
	picture4.y = 392
	scrollView:insert(picture4)

	picture5 = display.newImageRect("content/neorobots.png", 150, 40)
	picture5.x = _W * 0.5
	picture5.y = 460
	scrollView:insert(picture5)

	title2 = display.newText("Patroni medialni:", 0, 490, 150, 30, "HelveticaNeue", 20)
	title2:setReferencePoint(display.CenterReferencePoint)
	title2:setTextColor(166,42,42)
	title2.x = _W * 0.5
	scrollView:insert(title2)

	picture6 = display.newImageRect("content/afera.jpg", 150, 95)
	picture6.x = _W * 0.5
	picture6.y = 580
	scrollView:insert(picture6)

	picture7 = display.newImageRect("content/student.png", 150, 34)
	picture7.x = _W * 0.5
	picture7.y = 665
	scrollView:insert(picture7)

	picture8 = display.newImageRect("content/epoznan.jpg", 150, 41)
	picture8.x = _W * 0.5
	picture8.y = 725
	scrollView:insert(picture8)

	picture9 = display.newImageRect("content/forbot.png", 150, 31)
	picture9.x = _W * 0.5
	picture9.y = 786
	scrollView:insert(picture9)

	picture10 = display.newImageRect("content/mcradio.jpg", 150, 37)
	picture10.x = _W * 0.5
	picture10.y = 843
	scrollView:insert(picture10)

	picture11 = display.newImageRect("content/wtk.jpg", 150, 100)
	picture11.x = _W * 0.5
	picture11.y = 931
	scrollView:insert(picture11)

	picture12 = display.newImageRect("content/meteor.png", 150, 129)
	picture12.x = _W * 0.5
	picture12.y = 1065
	scrollView:insert(picture12)

	title3 = display.newText("Patroni honorowi:", 0, 1140, 157, 30, "HelveticaNeue", 20)
	title3:setReferencePoint(display.CenterReferencePoint)
	title3:setTextColor(166,42,42)
	title3.x = _W * 0.5
	scrollView:insert(title3)

	picture13 = display.newImageRect("content/poznan.jpg", 150, 50)
	picture13.x = _W * 0.5
	picture13.y = 1205
	scrollView:insert(picture13)

	picture14 = display.newImageRect("content/PP.png", 150, 100)
	picture14.x = _W * 0.5
	picture14.y = 1300
	scrollView:insert(picture14)

	picture15 = display.newImageRect("content/WE.png", 150, 100)
	picture15.x = _W * 0.5
	picture15.y = 1420
	scrollView:insert(picture15)
end

function onRectTouch(self,e)
	if e.phase == "began" then
		if e.y ~= nil and scrollView.y ~= nil then
			scrollViewy0 = e.y - scrollView.y
			start = e.y
		end
	end
	if "moved" == e.phase then
		if e.y ~= nil and scrollView.y ~= nil then
			move = e.y
			if scrollView.y > -1184 and scrollView.y < 187 then
				scrollView.y = e.y - scrollViewy0
			end
			if (scrollView.y <= -1184 and move > start)  or  (scrollView.y >= 187 and move < start) then
				scrollView.y = e.y - scrollViewy0
			end
		end
	end
	if e.phase == "ended" then
		start = 0
		move = 0
	end
end

function scene:enterScene(event)
	local group = self.view

	backButton._onRelease = function()
		storyboard.gotoScene("mainMenu", "slideRight", 400)
	end
end

function scene:exitScene(event)
	local group = self.view
	backButton._onRelease = nil
end

function scene:destroyScene(event)
	local group = self.view
	bg:removeSelf()
	rect:removeSelf()
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene
