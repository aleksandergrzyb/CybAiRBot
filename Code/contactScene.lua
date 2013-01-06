display.setStatusBar(display.HiddenStatusBar)

local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local storyboard = require("storyboard")
local scene = storyboard.newScene()

local scrollView
local scrollViewy0

local bg
local backButtton
local onRectTouch

local title1
local title2
local title3

local text1
local text2
local text3
local text4
local text5
local text6
local text7
local text8
local text9

local mapa
local image1
local image2
local image3

local lineTop
local bgTop


local start = 0
local move = 0

function scene:createScene(event)
	local group = self.view

	bg = display.newImageRect("img/bg.png", _DW, _DH)
	group:insert(bg)
	bg.x, bg.y = .5*_W, .5*_H

	scrollView = display.newGroup()
	group:insert(scrollView)

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

	rect = display.newRect(0,0,_W,_H)
	rect.touch = onRectTouch
	rect:addEventListener("touch",rect)
	rect.alpha = 0.01

	title1 = display.newText("Dojazd:", 0, 65, 80, 30, "HelveticaNeue", 20)
	title1:setReferencePoint(display.CenterReferencePoint)
	title1:setTextColor(166,42,42)
	title1.x = _W * 0.5
	scrollView:insert(title1)

	text1 = display.newText("Na miejsce zawodów można dojechać komunikacją miejską wysiadając na jednym z przystanków: Baraniaka, Politechnika lub Kórnicka (najbliżej Politechnika).", 0, 100, 280, 200, "HelveticaNeue", 13)
	text1:setReferencePoint(display.CenterReferencePoint)
	text1:setTextColor(242,174,39)
	text1.x = _W * 0.5
	scrollView:insert(text1)

	text2 = display.newText("Na przystanek Baraniaka dojeżdżają następujące tramwaje: 4,6,7,11,17.", 0, 190, 280, 100, "HelveticaNeue", 13)
	text2:setReferencePoint(display.CenterReferencePoint)
	text2:setTextColor(242,174,39)
	text2.x = _W * 0.5
	scrollView:insert(text2)

	text3 = display.newText("Na przystanek Politechnika dojeżdżają następujące tramwaje: 3,11,13,16.", 0, 240, 280, 100, "HelveticaNeue", 13)
	text3:setReferencePoint(display.CenterReferencePoint)
	text3:setTextColor(242,174,39)
	text3.x = _W * 0.5
	scrollView:insert(text3)

	text4 = display.newText("Na przystanek Kórnicka dojeżdżają następujące tramwaje: 3,4,6,7,11,13,16,17,27.", 0, 290, 280, 100, "HelveticaNeue", 13)
	text4:setReferencePoint(display.CenterReferencePoint)
	text4:setTextColor(242,174,39)
	text4.x = _W * 0.5
	scrollView:insert(text4)

	text5 = display.newText("W jaki sposób dojść z powyższych przystanków na miejsce zawodów tzn. Centrum Wykładowe Politechniki Poznańskiej obrazuje mapka poniżej:", 0, 340, 280, 200, "HelveticaNeue", 13)
	text5:setReferencePoint(display.CenterReferencePoint)
	text5:setTextColor(242,174,39)
	text5.x = _W * 0.5
	scrollView:insert(text5)

	mapa = display.newImageRect("content/mapa1.png", 280, 370)
	mapa.x = _W * 0.5
	mapa.y = 610
	scrollView:insert(mapa)

	text6 = display.newText("Dokładny adres miejsca odbycia zawodów to ul. Piotrowo 2, Poznań.", 0, 805, 280, 200, "HelveticaNeue", 13)
	text6:setReferencePoint(display.CenterReferencePoint)
	text6:setTextColor(242,174,39)
	text6.x = _W * 0.5
	scrollView:insert(text6)

	title2 = display.newText("Organizatorzy:", 0, 850, 130, 30, "HelveticaNeue", 20)
	title2:setReferencePoint(display.CenterReferencePoint)
	title2:setTextColor(166,42,42)
	title2.x = _W * 0.5
	scrollView:insert(title2)

	image1 = display.newImageRect("content/cybair.png", 153, 89)
	image1.x = _W * 0.5
	image1.y = 930
	scrollView:insert(image1)

	image2 = display.newImageRect("content/IAII.png", 150, 97)
	image2.x = _W * 0.5
	image2.y = 1043
	scrollView:insert(image2)

	image3 = display.newImageRect("content/PP.png", 150, 100)
	image3.x = _W * 0.5
	image3.y = 1161
	scrollView:insert(image3)

	text7 = display.newText("Z organizatorami można się skontaktować poprzez pocztę elektroniczną: sumo@put.poznan.pl", 0, 1220, 280, 200, "HelveticaNeue", 13)
	text7:setReferencePoint(display.CenterReferencePoint)
	text7:setTextColor(242,174,39)
	text7.x = _W * 0.5
	scrollView:insert(text7)

	text8 = display.newText("Strona internetowa zawodów: sumo.put.poznan.pl", 0, 1285, 280, 200, "HelveticaNeue", 13)
	text8:setReferencePoint(display.CenterReferencePoint)
	text8:setTextColor(242,174,39)
	text8.x = _W * 0.5
	scrollView:insert(text8)

	title3 = display.newText("Twórca aplikacji:", 0, 1340, 156, 30, "HelveticaNeue", 20)
	title3:setReferencePoint(display.CenterReferencePoint)
	title3:setTextColor(166,42,42)
	title3.x = _W * 0.5
	scrollView:insert(title3)

	text9 = display.newText("www.blerdo.com", 0, 1370, 280, 200, "HelveticaNeue", 13)
	text9:setReferencePoint(display.CenterReferencePoint)
	text9:setTextColor(242,174,39)
	text9.x = _W * 0.5
	scrollView:insert(text9)
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
			if scrollView.y > -1149 and scrollView.y < 194 then
				scrollView.y = e.y - scrollViewy0
			end
			if (scrollView.y <= -1149 and move > start)  or  (scrollView.y >= 194 and move < start) then
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

	backButtton._onRelease = function()
		storyboard.gotoScene("mainMenu", "slideRight", 400)
	end
end

function scene:exitScene(event)
	local group = self.view

	backButtton._onRelease = nil
end

function scene:destroyScene(event)
	local group = self.view
	backButtton:removeSelf()
	bg:removeSelf()
	rect:removeSelf()
end

scene:addEventListener("createScene", scene)
scene:addEventListener("enterScene", scene)
scene:addEventListener("exitScene", scene)
scene:addEventListener("destroyScene", scene)


return scene
