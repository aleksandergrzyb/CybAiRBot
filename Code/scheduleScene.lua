display.setStatusBar(display.HiddenStatusBar)

local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local _W = display.contentWidth
local _H = display.contentHeight

local storyboard = require("storyboard")
local scene = storyboard.newScene()

local bg
local backButtton
local onRectTouch

local scrollView
local scrollViewy0


local lineTop
local bgTop

local start = 0
local move = 0

function scene:createScene(event)
	local group = self.view


	local titleOne

	local hourOne
	local hourOne1
	local hourTwo
	local hourTwo1
	local hourTwo2
	local hourTwo3
	local hourTwo4
	local hourThree
	local hourThree1
	local hourFour
	local hourFour1
	local hourFour2
	local hourFour3
	local hourFive
	local hourFive1
	local hourFive2
	local hourFive3
	local hourSix
	local hourSix1
	local hourSix2
	local hourSix3
	local hourSeven
	local hourSeven1
	local hourEight
	local hourEight1
	local hourNine
	local hourNine1
	local hourNine2
	local hourTen
	local hourTen1
	local hourTen2
	local hourEleven
	local hourEleven1
	local hourEleven2
	local hourEleven3
	local hourEleven4
	local hourTwelfe
	local hourTwelfe1
	local hourTwelfe2
	local hourTwelfe3
	local hourThirteen
	local hourThirteen1
	local hourThirteen2
	local hourFourteen
	local hourFourteen1
	local hourFifteen
	local hourFifteen1
	local hourFifteen2
	local hourSixteen
	local hourSixteen1

	local titleTwo
	local titleTwo1
	local hour1
	local hour2
	local hour3
	local hour4

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

	titleOne = display.newText("CybAiRBot 2012 - Harmonogram", 0, 70, 300, 30, "HelveticaNeue", 20)
	titleOne:setReferencePoint(display.CenterReferencePoint)
	titleOne:setTextColor(71,60,139)
	titleOne.x = _W * 0.5
	scrollView:insert(titleOne)

	hourOne = display.newText("08:30", 0, 110, 44, 30, "HelveticaNeue", 16)
	hourOne:setReferencePoint(display.CenterReferencePoint)
	hourOne:setTextColor(166,42,42)
	hourOne.x = _W * 0.5
	scrollView:insert(hourOne)

	hourOne1 = display.newText("Rozpoczęcie rejestracji", 0, 130, 140, 30, "HelveticaNeue", 13)
	hourOne1:setReferencePoint(display.CenterReferencePoint)
	hourOne1:setTextColor(242,174,39)
	hourOne1.x = _W * 0.5
	scrollView:insert(hourOne1)

	hourTwo = display.newText("09:00", 0, 160, 44, 30, "HelveticaNeue", 16)
	hourTwo:setReferencePoint(display.CenterReferencePoint)
	hourTwo:setTextColor(166,42,42)
	hourTwo.x = _W * 0.5
	scrollView:insert(hourTwo)

	hourTwo1 = display.newText("Otwarcie pierwszej trasy eliminacyjnej line followerów", 0, 180, 313, 30, "HelveticaNeue", 13)
	hourTwo1:setReferencePoint(display.CenterReferencePoint)
	hourTwo1:setTextColor(242,174,39)
	hourTwo1.x = _W * 0.5
	scrollView:insert(hourTwo1)

	hourTwo2 = display.newText("Rozpoczęcie eliminacji sumo", 0, 200, 170, 30, "HelveticaNeue", 13)
	hourTwo2:setReferencePoint(display.CenterReferencePoint)
	hourTwo2:setTextColor(242,174,39)
	hourTwo2.x = _W * 0.5
	scrollView:insert(hourTwo2)

	hourTwo3 = display.newText("Rozpoczęcie eliminacji minisumo", 0, 220, 200, 30, "HelveticaNeue", 13)
	hourTwo3:setReferencePoint(display.CenterReferencePoint)
	hourTwo3:setTextColor(242,174,39)
	hourTwo3.x = _W * 0.5
	scrollView:insert(hourTwo3)

	hourTwo4 = display.newText("Rozpoczęcie eliminacji nanosumo", 0, 240, 200, 30, "HelveticaNeue", 13)
	hourTwo4:setReferencePoint(display.CenterReferencePoint)
	hourTwo4:setTextColor(242,174,39)
	hourTwo4.x = _W * 0.5
	scrollView:insert(hourTwo4)

	hourThree = display.newText("10:00", 0, 270, 44, 30, "HelveticaNeue", 16)
	hourThree:setReferencePoint(display.CenterReferencePoint)
	hourThree:setTextColor(166,42,42)
	hourThree.x = _W * 0.5
	scrollView:insert(hourThree)

	hourThree1 = display.newText("Zakończenie rejestracji", 0, 290, 140, 30, "HelveticaNeue", 13)
	hourThree1:setReferencePoint(display.CenterReferencePoint)
	hourThree1:setTextColor(242,174,39)
	hourThree1.x = _W * 0.5
	scrollView:insert(hourThree1)

	hourFour = display.newText("10:30", 0, 320, 44, 30, "HelveticaNeue", 16)
	hourFour:setReferencePoint(display.CenterReferencePoint)
	hourFour:setTextColor(166,42,42)
	hourFour.x = _W * 0.5
	scrollView:insert(hourFour)

	hourFour1 = display.newText("Zakończenie eliminacji sumo", 0, 340, 170, 30, "HelveticaNeue", 13)
	hourFour1:setReferencePoint(display.CenterReferencePoint)
	hourFour1:setTextColor(242,174,39)
	hourFour1.x = _W * 0.5
	scrollView:insert(hourFour1)

	hourFour2 = display.newText("Zakończenie eliminacji minisumo", 0, 360, 190, 30, "HelveticaNeue", 13)
	hourFour2:setReferencePoint(display.CenterReferencePoint)
	hourFour2:setTextColor(242,174,39)
	hourFour2.x = _W * 0.5
	scrollView:insert(hourFour2)

	hourFour3 = display.newText("Zakończenie eliminacji nanosumo", 0, 380, 200, 30, "HelveticaNeue", 13)
	hourFour3:setReferencePoint(display.CenterReferencePoint)
	hourFour3:setTextColor(242,174,39)
	hourFour3.x = _W * 0.5
	scrollView:insert(hourFour3)

	hourFive = display.newText("10:45", 0, 410, 44, 30, "HelveticaNeue", 16)
	hourFive:setReferencePoint(display.CenterReferencePoint)
	hourFive:setTextColor(166,42,42)
	hourFive.x = _W * 0.5
	scrollView:insert(hourFive)

	hourFive1 = display.newText("Zawody sumo - faza grupowa", 0, 430, 180, 30, "HelveticaNeue", 13)
	hourFive1:setReferencePoint(display.CenterReferencePoint)
	hourFive1:setTextColor(242,174,39)
	hourFive1.x = _W * 0.5
	scrollView:insert(hourFive1)

	hourFive2 = display.newText("Zawody minisumo - faza grupowa", 0, 450, 200, 30, "HelveticaNeue", 13)
	hourFive2:setReferencePoint(display.CenterReferencePoint)
	hourFive2:setTextColor(242,174,39)
	hourFive2.x = _W * 0.5
	scrollView:insert(hourFive2)

	hourFive3 = display.newText("Zawody nanosumo - faza grupowa", 0, 470, 202, 30, "HelveticaNeue", 13)
	hourFive3:setReferencePoint(display.CenterReferencePoint)
	hourFive3:setTextColor(242,174,39)
	hourFive3.x = _W * 0.5
	scrollView:insert(hourFive3)

	hourSix = display.newText("11:00", 0, 500, 44, 30, "HelveticaNeue", 16)
	hourSix:setReferencePoint(display.CenterReferencePoint)
	hourSix:setTextColor(166,42,42)
	hourSix.x = _W * 0.5
	scrollView:insert(hourSix)

	hourSix1 = display.newText("Zamknięcie pierwszej trasy eliminacyjnej line", 0, 520, 270, 30, "HelveticaNeue", 13)
	hourSix1:setReferencePoint(display.CenterReferencePoint)
	hourSix1:setTextColor(242,174,39)
	hourSix1.x = _W * 0.5
	scrollView:insert(hourSix1)

	hourSix2 = display.newText("followerów", 0, 540, 65, 30, "HelveticaNeue", 13)
	hourSix2:setReferencePoint(display.CenterReferencePoint)
	hourSix2:setTextColor(242,174,39)
	hourSix2.x = _W * 0.5
	scrollView:insert(hourSix2)

	hourSix3 = display.newText("Wykład - Historia robotyki", 0, 560, 180, 30, "HelveticaNeue", 13)
	hourSix3:setReferencePoint(display.CenterReferencePoint)
	hourSix3:setTextColor(242,174,39)
	hourSix3.x = _W * 0.5
	scrollView:insert(hourSix3)

	hourSeven = display.newText("11:45", 0, 590, 44, 30, "HelveticaNeue", 16)
	hourSeven:setReferencePoint(display.CenterReferencePoint)
	hourSeven:setTextColor(166,42,42)
	hourSeven.x = _W * 0.5
	scrollView:insert(hourSeven)

	hourSeven1 = display.newText("Otwarcie drugiej trasy eliminacyjnej line followerów", 0, 610, 300, 30, "HelveticaNeue", 13)
	hourSeven1:setReferencePoint(display.CenterReferencePoint)
	hourSeven1:setTextColor(242,174,39)
	hourSeven1.x = _W * 0.5
	scrollView:insert(hourSeven1)

	hourEight = display.newText("12:30", 0, 640, 44, 30, "HelveticaNeue", 16)
	hourEight:setReferencePoint(display.CenterReferencePoint)
	hourEight:setTextColor(166,42,42)
	hourEight.x = _W * 0.5
	scrollView:insert(hourEight)

	hourEight1 = display.newText("CybAiRBot 2012 - Oficjalne rozpoczęcie", 0, 660, 290, 30, "HelveticaNeue", 16)
	hourEight1:setReferencePoint(display.CenterReferencePoint)
	hourEight1:setTextColor(69,139,116)
	hourEight1.x = _W * 0.5
	scrollView:insert(hourEight1)

	hourNine = display.newText("13:00", 0, 690, 44, 30, "HelveticaNeue", 16)
	hourNine:setReferencePoint(display.CenterReferencePoint)
	hourNine:setTextColor(166,42,42)
	hourNine.x = _W * 0.5
	scrollView:insert(hourNine)

	hourNine1 = display.newText("Wykład - Jak robot widzi świat", 0, 710, 183, 30, "HelveticaNeue", 13)
	hourNine1:setReferencePoint(display.CenterReferencePoint)
	hourNine1:setTextColor(242,174,39)
	hourNine1.x = _W * 0.5
	scrollView:insert(hourNine1)

	hourNine2 = display.newText("Zawody nanosumo - półfinały", 0, 730, 175, 30, "HelveticaNeue", 13)
	hourNine2:setReferencePoint(display.CenterReferencePoint)
	hourNine2:setTextColor(242,174,39)
	hourNine2.x = _W * 0.5
	scrollView:insert(hourNine2)

	hourTen = display.newText("13:45", 0, 760, 44, 30, "HelveticaNeue", 16)
	hourTen:setReferencePoint(display.CenterReferencePoint)
	hourTen:setTextColor(166,42,42)
	hourTen.x = _W * 0.5
	scrollView:insert(hourTen)

	hourTen1 = display.newText("Zamknięcie drugiej trasy eliminacyjnej line followerów", 0, 780, 312, 30, "HelveticaNeue", 13)
	hourTen1:setReferencePoint(display.CenterReferencePoint)
	hourTen1:setTextColor(242,174,39)
	hourTen1.x = _W * 0.5
	scrollView:insert(hourTen1)

	hourTen2 = display.newText("Zawody nanosumo - mecz o 3 miejsce i Wielki Finał", 0, 800, 305, 30, "HelveticaNeue", 13)
	hourTen2:setReferencePoint(display.CenterReferencePoint)
	hourTen2:setTextColor(242,174,39)
	hourTen2.x = _W * 0.5
	scrollView:insert(hourTen2)

	hourEleven = display.newText("14:30", 0, 830, 44, 30, "HelveticaNeue", 16)
	hourEleven:setReferencePoint(display.CenterReferencePoint)
	hourEleven:setTextColor(166,42,42)
	hourEleven.x = _W * 0.5
	scrollView:insert(hourEleven)

	hourEleven1 = display.newText("Wykład - Jak zbudować pierwszego robota", 0, 850, 260, 30, "HelveticaNeue", 13)
	hourEleven1:setReferencePoint(display.CenterReferencePoint)
	hourEleven1:setTextColor(242,174,39)
	hourEleven1.x = _W * 0.5
	scrollView:insert(hourEleven1)

	hourEleven2 = display.newText("Otwarcie trasy finałowej line followerów", 0, 870, 240, 30, "HelveticaNeue", 13)
	hourEleven2:setReferencePoint(display.CenterReferencePoint)
	hourEleven2:setTextColor(242,174,39)
	hourEleven2.x = _W * 0.5
	scrollView:insert(hourEleven2)

	hourEleven3 = display.newText("Zawody sumo - ćwierćfinały", 0, 890, 170, 30, "HelveticaNeue", 13)
	hourEleven3:setReferencePoint(display.CenterReferencePoint)
	hourEleven3:setTextColor(242,174,39)
	hourEleven3.x = _W * 0.5
	scrollView:insert(hourEleven3)

	hourEleven4 = display.newText("Zawody minisumo - ćwierćfinały", 0, 910, 190, 30, "HelveticaNeue", 13)
	hourEleven4:setReferencePoint(display.CenterReferencePoint)
	hourEleven4:setTextColor(242,174,39)
	hourEleven4.x = _W * 0.5
	scrollView:insert(hourEleven4)

	hourTwelfe = display.newText("15:00", 0, 940, 44, 30, "HelveticaNeue", 16)
	hourTwelfe:setReferencePoint(display.CenterReferencePoint)
	hourTwelfe:setTextColor(166,42,42)
	hourTwelfe.x = _W * 0.5
	scrollView:insert(hourTwelfe)

	hourTwelfe1 = display.newText("Zawody sumo - półfinały", 0, 960, 150, 30, "HelveticaNeue", 13)
	hourTwelfe1:setReferencePoint(display.CenterReferencePoint)
	hourTwelfe1:setTextColor(242,174,39)
	hourTwelfe1.x = _W * 0.5
	scrollView:insert(hourTwelfe1)

	hourTwelfe2 = display.newText("Zawody minisumo - półfinały", 0, 980, 170, 30, "HelveticaNeue", 13)
	hourTwelfe2:setReferencePoint(display.CenterReferencePoint)
	hourTwelfe2:setTextColor(242,174,39)
	hourTwelfe2.x = _W * 0.5
	scrollView:insert(hourTwelfe2)

	hourTwelfe3 = display.newText("Zamknięcie głosowania w kategorii freestyle", 0, 1000, 260, 30, "HelveticaNeue", 13)
	hourTwelfe3:setReferencePoint(display.CenterReferencePoint)
	hourTwelfe3:setTextColor(242,174,39)
	hourTwelfe3.x = _W * 0.5
	scrollView:insert(hourTwelfe3)

	hourThirteen = display.newText("15:30", 0, 1030, 40, 30, "HelveticaNeue", 16)
	hourThirteen:setReferencePoint(display.CenterReferencePoint)
	hourThirteen:setTextColor(166,42,42)
	hourThirteen.x = _W * 0.5
	scrollView:insert(hourThirteen)

	hourThirteen1 = display.newText("Zamknięcie trasy finałowej line followerów", 0, 1050, 250, 30, "HelveticaNeue", 13)
	hourThirteen1:setReferencePoint(display.CenterReferencePoint)
	hourThirteen1:setTextColor(242,174,39)
	hourThirteen1.x = _W * 0.5
	scrollView:insert(hourThirteen1)

	hourThirteen2 = display.newText("Zawody minisumo - mecz o 3 miejsce i Wielki Finał", 0, 1070, 299, 30, "HelveticaNeue", 13)
	hourThirteen2:setReferencePoint(display.CenterReferencePoint)
	hourThirteen2:setTextColor(242,174,39)
	hourThirteen2.x = _W * 0.5
	scrollView:insert(hourThirteen2)

	hourFourteen = display.newText("16:00", 0, 1100, 44, 30, "HelveticaNeue", 16)
	hourFourteen:setReferencePoint(display.CenterReferencePoint)
	hourFourteen:setTextColor(166,42,42)
	hourFourteen.x = _W * 0.5
	scrollView:insert(hourFourteen)

	hourFourteen1 = display.newText("Zawody sumo - mecz o 3 miejsce i Wielki Finał", 0, 1120, 280, 30, "HelveticaNeue", 13)
	hourFourteen1:setReferencePoint(display.CenterReferencePoint)
	hourFourteen1:setTextColor(242,174,39)
	hourFourteen1.x = _W * 0.5
	scrollView:insert(hourFourteen1)

	hourFifteen = display.newText("16:30", 0, 1150, 44, 30, "HelveticaNeue", 16)
	hourFifteen:setReferencePoint(display.CenterReferencePoint)
	hourFifteen:setTextColor(166,42,42)
	hourFifteen.x = _W * 0.5
	scrollView:insert(hourFifteen)

	hourFifteen1 = display.newText("Wręczenie nagród zwyciezcom oraz ogłoszenie", 0, 1180, 280, 30, "HelveticaNeue", 13)
	hourFifteen1:setReferencePoint(display.CenterReferencePoint)
	hourFifteen1:setTextColor(242,174,39)
	hourFifteen1.x = _W * 0.5
	scrollView:insert(hourFifteen1)

	hourFifteen2 = display.newText("zwycięzcy w kategorii freestyle", 0, 1200, 190, 30, "HelveticaNeue", 13)
	hourFifteen2:setReferencePoint(display.CenterReferencePoint)
	hourFifteen2:setTextColor(242,174,39)
	hourFifteen2.x = _W * 0.5
	scrollView:insert(hourFifteen2)

	hourSixteen = display.newText("17:00", 0, 1230, 44, 30, "HelveticaNeue", 16)
	hourSixteen:setReferencePoint(display.CenterReferencePoint)
	hourSixteen:setTextColor(166,42,42)
	hourSixteen.x = _W * 0.5
	scrollView:insert(hourSixteen)

	hourSixteen1 = display.newText("CybAiRBot 2012 - Oficjalne zakończenie", 0, 1250, 295, 30, "HelveticaNeue", 16)
	hourSixteen1:setReferencePoint(display.CenterReferencePoint)
	hourSixteen1:setTextColor(69,139,116)
	hourSixteen1.x = _W * 0.5
	scrollView:insert(hourSixteen1)

	titleTwo = display.newText("Warsztaty z klocków Lego Mindstorms", 0, 1300, 310, 30, "HelveticaNeue", 18)
	titleTwo:setReferencePoint(display.CenterReferencePoint)
	titleTwo:setTextColor(71,60,139)
	titleTwo.x = _W * 0.5
	scrollView:insert(titleTwo)

	titleTwo1 = display.newText("odbywają się w godzinach:", 0, 1320, 	218, 30, "HelveticaNeue", 18)
	titleTwo1:setReferencePoint(display.CenterReferencePoint)
	titleTwo1:setTextColor(71,60,139)
	titleTwo1.x = _W * 0.5
	scrollView:insert(titleTwo1)

	hour1 = display.newText("11:30 - 12:30", 0, 1350, 95, 30, "HelveticaNeue", 16)
	hour1:setReferencePoint(display.CenterReferencePoint)
	hour1:setTextColor(166,42,42)
	hour1.x = _W * 0.5
	scrollView:insert(hour1)

	hour2 = display.newText("12:45 - 13:45", 0, 1370, 95, 30, "HelveticaNeue", 16)
	hour2:setReferencePoint(display.CenterReferencePoint)
	hour2:setTextColor(166,42,42)
	hour2.x = _W * 0.5
	scrollView:insert(hour2)

	hour3 = display.newText("14:00 - 15:00", 0, 1390, 95, 30, "HelveticaNeue", 16)
	hour3:setReferencePoint(display.CenterReferencePoint)
	hour3:setTextColor(166,42,42)
	hour3.x = _W * 0.5
	scrollView:insert(hour3)

	hour4 = display.newText("15:15 - 16:15", 0, 1410, 95, 30, "HelveticaNeue", 16)
	hour4:setReferencePoint(display.CenterReferencePoint)
	hour4:setTextColor(166,42,42)
	hour4.x = _W * 0.5
	scrollView:insert(hour4)
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
			if scrollView.y > -1163 and scrollView.y < 214 then
				scrollView.y = e.y - scrollViewy0
			end
			if (scrollView.y <= -1163 and move > start)  or  (scrollView.y >= 214 and move < start) then
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
