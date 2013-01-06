display.setStatusBar(display.HiddenStatusBar)

local GTween = require "GTween"
local BlerdoButton = require "BlerdoButton"

local storyboard = require("storyboard")
local scene = storyboard.newScene()


local onRectTouch


local bg
local rect
local backButtton

local sumoTitleText
--local sumoTitleTexty0
local sumoText
--local sumoTexty0

local minisumoTitleText
--local minisumoTitleTexty0
local minisumoText
--local minisumoTexty0

local lineFollowerTitleText
--local lineFollowerTitleTexty0
local lineFollowerText
--local lineFollowerTexty0

local swiatlolubTitleText
--local swiatlolubTitleTexty0
local swiatlolubText
--local swiatlolubTexty0

local freestyleTitleText
local freestyleText

local nanoSumoTitleText
local nanoSumoText

local scrollView
local scrollViewy0

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

	sumoTitleText = display.newRetinaText("SUMO", 0, 65, 50, 30, "HelveticaNeue", 15)
	sumoTitleText:setReferencePoint(display.CenterReferencePoint)
	sumoTitleText:setTextColor(166,42,42)
	sumoTitleText.x = _W * 0.5
	--sumoTitleTexty0 = 0
	scrollView:insert(sumoTitleText)
	--group:insert(sumoTitleText)

	sumoText = display.newRetinaText("Konkurencja, która towarzyszy zawodom od początku ich powstania. Autonomiczne roboty walczą ze sobą na specjalnie przygotowanym okrągłym ringu, a ich celem jest wypchnąć przeciwnika. Ta zdecydowanie najbardziej emocjonująca konkurencja odbędzie się na scenie największej auli Politechniki Poznańskiej.", 0, 85, 280, 200, "HelveticaNeue", 13)
	sumoText:setReferencePoint(display.CenterReferencePoint)
	sumoText:setTextColor(242,174,39)
	sumoText.x = _W * 0.5
	--sumoTexty0 = 0
	scrollView:insert(sumoText)
	--group:insert(sumoText)

	minisumoTitleText = display.newRetinaText("MINISUMO", 0, 240, 80, 30, "HelveticaNeue", 15)
	minisumoTitleText:setReferencePoint(display.CenterReferencePoint)
	minisumoTitleText:setTextColor(166,42,42)
	minisumoTitleText.x = _W * 0.5
	--minisumoTitleTexty0 = 0
	scrollView:insert(minisumoTitleText)
	--group:insert(minisumoTitleText)

	minisumoText = display.newRetinaText("Minisumo polega na miniaturyzacji kategorii sumo. Zasady obu konkurencji są takie same, ale roboty mini sumo muszą zmieścić się na kwadracie o rozmiarach 10cm x 10 cm. Tak ograniczone rozmiary wymagają od konstruktorów pomysłowych rozwiązań, łączących miniaturyzację i kreatywność. Konkurencja ta obecna jest w harmonogramie zawodów dopiero od tego roku, więc prawdziwych emocji na pewno będzie pod dostatkiem.", 0, 260, 280, 300, "HelveticaNeue", 13)
	minisumoText:setReferencePoint(display.CenterReferencePoint)
	minisumoText:setTextColor(242,174,39)
	minisumoText.x = _W * 0.5
	--minisumoTexty0 = 0
	scrollView:insert(minisumoText)
	--group:insert(minisumoText)

	lineFollowerTitleText = display.newRetinaText("LINE FOLLOWER", 0, 480, 120, 400, "HelveticaNeue", 15)
	lineFollowerTitleText:setReferencePoint(display.CenterReferencePoint)
	lineFollowerTitleText:setTextColor(166,42,42)
	lineFollowerTitleText.x = _W * 0.5
	--lineFollowerTitleTexty0 = 0
	scrollView:insert(lineFollowerTitleText)
	--group:insert(lineFollowerTitleText)

	lineFollowerText = display.newRetinaText("Minisumo polega na miniaturyzacji kategorii sumo. Zasady obu konkurencji są takie same, ale roboty mini sumo muszą zmieścić się na kwadracie o rozmiarach 10cm x 10 cm. Tak ograniczone rozmiary wymagają od konstruktorów pomysłowych rozwiązań, łączących miniaturyzację i kreatywność. Konkurencja ta obecna jest w harmonogramie zawodów dopiero od tego roku, więc prawdziwych emocji na pewno będzie pod dostatkiem.", 0, 500, 280, 400, "HelveticaNeue", 13)
	lineFollowerText:setReferencePoint(display.CenterReferencePoint)
	lineFollowerText:setTextColor(242,174,39)
	lineFollowerText.x = _W * 0.5
	--lineFollowerTexty0 = 0
	scrollView:insert(lineFollowerText)
	--group:insert(lineFollowerText)

	swiatlolubTitleText = display.newRetinaText("ŚWIATŁOLUBY", 0, 725, 105, 400, "HelveticaNeue", 15)
	swiatlolubTitleText:setReferencePoint(display.CenterReferencePoint)
	swiatlolubTitleText:setTextColor(166,42,42)
	swiatlolubTitleText.x = _W * 0.5
	--swiatlolubTitleTexty0 = 0
	scrollView:insert(swiatlolubTitleText)
	--group:insert(swiatlolubTitleText)

	swiatlolubText = display.newRetinaText("Światłolub to robot, który zawsze jest głodny światła! Mobilna platforma podąża za latarką, która trzymana jest przez zawodnika. To świetna zabawa przede wszystkim dla młodych adeptów robotyki, ale także dla dorosłych. Celem zawodów jest takie poprowadzenie robota za pomocą latarki, aby jak najszybciej przejechał trasę wyznaczoną między linią START i META. Jeśli posiadasz swojego światłoluba - zarejestruj się poprzez formularz na stronie. Jeśli nie posiadasz, a Ty lub twoje dziecko chciałbyś wziąć udział w zawodach - nie martw się, firma Trobot przygotowała dla Was światłoluby w kategorii open, która nie wymaga rejestracji!", 0, 745, 280, 400, "HelveticaNeue", 13)
	swiatlolubText:setReferencePoint(display.CenterReferencePoint)
	swiatlolubText:setTextColor(242,174,39)
	swiatlolubText.x = _W * 0.5
	--swiatlolubTexty0 = 0
	scrollView:insert(swiatlolubText)
	--group:insert(swiatlolubText)

	freestyleTitleText = display.newRetinaText("FREESTYLE", 0, 1050, 90, 400, "HelveticaNeue", 15)
	freestyleTitleText:setReferencePoint(display.CenterReferencePoint)
	freestyleTitleText:setTextColor(166,42,42)
	freestyleTitleText.x = _W * 0.5
	--freestyleTitleTexty0 = 0
	scrollView:insert(freestyleTitleText)
	--group:insert(swiatlolubTitleText)

	freestyleText = display.newRetinaText("W kategorii freestyle nie ma żadnych reguł! Przynieś robota, który błyska diodami, leje kawę czy układa kostkę Rubika. Nie ważne jak wygląda, nie ważne co robi - ważne, żeby urzekł publiczność. To właśnie publika odpowiedzialna jest w tym roku za sędziowanie konkurencji freestyle - każdy odwiedzający będzie głosował na jedną, ich zdaniem najbardziej wyszukaną konstrukcję. Nie zwlekajcie i rejestrujcie się już dziś - a jeśli potrzebujecie specjalnych stanowisk czy przedmiotów do prezentacji - piszcie! ", 0, 1070, 280, 400, "HelveticaNeue", 13)
	freestyleText:setReferencePoint(display.CenterReferencePoint)
	freestyleText:setTextColor(242,174,39)
	freestyleText.x = _W * 0.5
	--freestyleTexty0 = 0
	scrollView:insert(freestyleText)
	--group:insert(swiatlolubText)

	nanoSumoTitleText = display.newRetinaText("NANOSUMO", 0, 1320, 90, 400, "HelveticaNeue", 15)
	nanoSumoTitleText:setReferencePoint(display.CenterReferencePoint)
	nanoSumoTitleText:setTextColor(166,42,42)
	nanoSumoTitleText.x = _W * 0.5
	--freestyleTitleTexty0 = 0
	scrollView:insert(nanoSumoTitleText)
	--group:insert(swiatlolubTitleText)

	nanoSumoText = display.newRetinaText("Jeśli myślicie, że istnieje granica miniaturyzacji i minimalizacji to się mylicie! Nanosumo to roboty walczące w ten sam sposób, jak ich więksi bracia, ale o nadzwyczajnie małych rozmiarach. Nie może was ominąć widowisko, w którym maszyny wielkością porównywalne z pięciozłotówką walczą na ringu o średnicy 19 cm! Całkowicie autonomiczne, z własnym zasilaniem i malutkimi silnikami zmierzą się w walce, której tradycja sięga zeszłego tysiąclecia!", 0, 1340, 280, 400, "HelveticaNeue", 13)
	nanoSumoText:setReferencePoint(display.CenterReferencePoint)
	nanoSumoText:setTextColor(242,174,39)
	nanoSumoText.x = _W * 0.5
	--freestyleTexty0 = 0
	scrollView:insert(nanoSumoText)
	--group:insert(swiatlolubText)

	scrollViewy0 = 0

	backButtton = BlerdoButton.newAdvBtn({normal = "img/back.png", over = "img/back_touch.png", normalWidth=100, normalHeight=80})
	group:insert(backButtton)
	backButtton.x, backButtton.y = display.screenOriginX -5, display.screenOriginY -5

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

	backButtton._onRelease = function()
		storyboard.gotoScene("mainMenu", "slideRight", 400)
	end

	rect:addEventListener("touch",rect)
end

function scene:exitScene(event)
	local group = self.view

	backButtton._onRelease = nil
	rect:removeEventListener("touch",rect)
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