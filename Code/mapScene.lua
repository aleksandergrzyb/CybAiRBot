display.setStatusBar(display.HiddenStatusBar)

local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local storyboard = require("storyboard")
local scene = storyboard.newScene()

local onRectTouch

local bg
local backButtton
local myImage

local lineTop
local bgTop

local startX = 0
local moveX = 0
local startY = 0
local moveY = 0

function scene:createScene(event)
	local group = self.view

	bg = display.newImageRect("img/bg.png", _DW, _DH)
	group:insert(bg)
	bg.x, bg.y = .5*_W, .5*_H

	myImage = display.newImage("content/CW.jpg", 10, 20, true)
	myImage:toBack()
	group:insert(myImage)
	myImage.touch = onRectTouch
	myImage:addEventListener("touch", myImage)

	topBg = display.newImageRect("img/top_bg.png", _DW, 100)
	group:insert(topBg)
	topBg:setReferencePoint(display.TopCenterReferencePoint)
	topBg.x, topBg.y = .5*_W, display.screenOriginY-30

	lineTop = display.newImageRect("img/main/line_top.png", 320, 4)
	lineTop.x = _W * 0.5
	lineTop.y = topBg.y + 90
	group:insert(lineTop)

	backButtton = BlerdoButton.newAdvBtn({normal = "img/back.png", over = "img/back_touch.png", normalWidth=100, normalHeight=80})
	group:insert(backButtton)
	backButtton.x, backButtton.y = display.screenOriginX -5, display.screenOriginY -5

end

function onRectTouch(self,e)
	local t = e.target
		if e.phase == "began" then
			if e.y ~= nil and t.y ~= nil and e.x ~= nil and t.x ~= nil then
				t.x0 = e.x - t.x
				t.y0 = e.y - t.y

				startX = e.x
				startY = e.y
			end
		end
		if "moved" == e.phase then
			if e.y ~= nil and t.y ~= nil and e.x ~= nil and t.x ~= nil then
				print("Pozycja x " .. t.x)
				print("pozycja y " .. t.y)
				moveX = e.x
				moveY = e.y
				if t.x > - 340 and t.x < 650 then
					if t.y > -90 and t.y < 615 then
						t.x = e.x - t.x0
						t.y = e.y - t.y0
					end
				end

				if t.x >= 650 and t.y >= -90 and t.y <= 615 and moveX < startX then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end

				if t.x <= -340 and t.y >= -90 and t.y <= 615 and moveX > startX then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end

				if t.y <= -90 and t.x >= -340 and t.x <= 650 and moveY > startY then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end

				if t.y >= 615 and t.x >= -340 and t.x <= 650 and moveY < startY then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end





				if t.x <= -340 and t.y <= -90 and moveX > startX and moveY > startY then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end

				if t.x >= 650 and t.y <= -90 and moveX < startX and moveY > startY then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end

				if t.x <= -340 and t.y >= 615 and moveX > startX and moveY < startY then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end

				if t.x >= 650 and t.y >= 615 and moveX < startX and moveY < startY then
					t.x = e.x - t.x0
					t.y = e.y - t.y0
				end
			end
		end
	if e.phase == "ended" then
		startX = 0
		startY = 0
		moveY = 0
		moveX = 0
	end
end

function scene:enterScene(event)
	local group = self.view

	backButtton._onRelease = function()
		storyboard.gotoScene("mainMenu", "slideRight", 400)
	end
end

function scene:exitScene(event)
	local group = self.view
	myImage:removeSelf()
	backButtton._onRelease = nil
	myImage:removeEventListener("touch", myImage)
end

function scene:destroyScene(event)
	local group = self.view
	bg:removeSelf()
	backButtton:removeSelf()
end


scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene
