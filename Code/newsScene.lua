local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local storyboard = require("storyboard")
local scene = storyboard.newScene()
local xml = require("xml").newParser()
local networkListener
local showScores

local bg
local topBg
local lineTop
local backButtton
local lineOne
local lineTwo
local nazwa

local konkurencje = {} -- <-- 1 - nazwy, 2 - mode

local konkurencjaRaceText = {}
local zawodnicyRaceText = {}

local zawodnikRace = {} -- <-- 1 - pozycja , 2 - nazwa, 3 - czas, struktura [a][b][c] a - konkurencja, b - zawodnicy, c - parametry zawodników

local start = 0
local move = 0

local onRectTouch

local scrollView
local scrollViewy0
local rect

local odl = 0
local race = 1
local playerRace = 1


function showScores(  )
	local group = storyboard.view
	print("mam do pokazania: "..#konkurencje)

	for i = 1,#konkurencje do
			konkurencjaRaceText[i] = display.newText("Konkurencja: " .. konkurencje[i][1], 0, 100 + odl * 20, 220, 400, "HelveticaNeue", 18)
			konkurencjaRaceText[i]:setTextColor(242,174,39)
			konkurencjaRaceText[i].x = _W * 0.5
			scrollView:insert(konkurencjaRaceText[i])
			odl = odl + 1
			if konkurencje[i][2] == "race" then
				zawodnicyRaceText[race] = {}
				zawodnicyRaceText[race] = display.newText("Zawodnicy: ", 0, 100 + odl * 20, 220, 400, "HelveticaNeue", 18)
				zawodnicyRaceText[race]:setTextColor(242,174,39)
				zawodnicyRaceText[race].x = _W * 0.5
				scrollView:insert(zawodnicyRaceText[race])
				odl = odl + 1
				
				local current = nil
				for a = 1,#zawodnikRace[race] do
					current = display.newText("Nazwa: " .. zawodnikRace[race][a][2], 0, 100 + odl * 20, 320, 400, "HelveticaNeue", 18)
					current:setTextColor(242,174,39)
					current.x = _W * 0.5
					scrollView:insert(current)
					zawodnicyRaceText[race][a] = current
					odl = odl + 1
				end

				race = race + 1
			end
	end
end


function networkListener( event )
		if ( event.isError ) then
				print ( "Network error - download failed" )
		else
			print ( "Network good" )
			local inbox = xml:loadFile("scores.xml", system.DocumentsDirectory)

			--print(#inbox.child[1].child)
			--print(inbox.child[1].child[2].value) -- mode
			for i = 1,#inbox.child do
				konkurencje[i] = {}
				for d = 1,2 do
					konkurencje[i][d] = inbox.child[i].child[d].value
				end
				if inbox.child[i].child[2].value == "race" then
					zawodnikRace[i] = {}
					for a = 1,#inbox.child[i].child - 2 do
						zawodnikRace[i][a] = {}
						for c = 1,3 do
							zawodnikRace[i][a][c] = inbox.child[i].child[a + 2].child[c].value
						end
					end
				end
			end

		end
		print ( "RESPONSE: " .. event.response )
		showScores()
end

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

	backButtton._onRelease = function()
		storyboard.gotoScene("mainMenu", "slideRight", 400)
	end

	scrollViewy0 = 0

	lineOne = display.newText( "WYNIKI:", 0, 80, 220, 400, "HelveticaNeue", 18 )
	lineOne:setReferencePoint(display.CenterReferencePoint)
	lineOne:setTextColor(242,174,39)
	lineOne.x = _W * 0.5
	scrollView:insert(lineOne)

	rect = display.newRect(0,0,_W,_H)
	rect.touch = onRectTouch
	rect.alpha = 0.01
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
			if scrollView.y > -1250 and scrollView.y < 247 then
				scrollView.y = e.y - scrollViewy0
			end
			if (scrollView.y <= -1250 and move > start)  or  (scrollView.y >= 247 and move < start) then
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

	network.download("http://sumo.put.poznan.pl/wyniki/scores.xml", "GET", networkListener, "scoress.xml", system.TemporaryDirectory )

	rect:addEventListener("touch",rect)

	--local tekst = display.newText( nazwa, 0, 200, 160, 400, "HelveticaNeue", 18 )
	--group:insert(tekst)

	-- inbox.child[1].child[1].value <-- title
	-- inbox.child[1].child[2].value <-- mode
end

function scene:exitScene(event)
	local group = self.view
	rect:removeEventListener("touch",rect)

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
