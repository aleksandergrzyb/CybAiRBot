local Slider = {}

local GameSelect = require "GameSelect"

local screenW, screenH = display.contentWidth, display.contentHeight
local viewableScreenW, viewableScreenH = display.viewableContentWidth, display.viewableContentHeight
local screenOffsetW, screenOffsetH = display.contentWidth -  display.viewableContentWidth, display.contentHeight - display.viewableContentHeight
local abs = math.abs

local slideTime = 400--ms
local w, h = 200, 120
local pad = 40
local offset = w + pad
local dragTolerance = 5

Slider.new = function( imageSet, top, bottom )
	--functions
	local setSlideNumber
	local touchListener
	local gameSelected
	local cancelTween
	local nextImage
	local prevImage
	local cancelMove
	local initImage
	local addTouchEvent
	local removeTouchEvent
	local activate
	local playFullLevel

	local m = display.newGroup()
	m.slides = display.newGroup()
	m.top = top or 0 
	m.bottom = bottom or 0
	m.imgNum = nil
	m.images = nil
	m.startPos = 0
	m.prevPos = 0
	m.isDrag = false
	m.dragDistance = 0
	m.isActive = true
	
	--m.slides.x = screenW * 0.5
	--m.slides.y = screenH * 0.5
	m.slides.x, m.slides.y = 0,0
	m:insert(m.slides)

	m.images = {}
	for i = 1,#imageSet do
		--local p = display.newImage(imageSet[i])
		--local p = display.newRect(0,0, w,h, "c")
		local p = GameSelect.new(imageSet[i])
		m.slides:insert(p)
		p.x = (i-1) * offset
		p.ox = p.x
		m.images[#m.images+1] = p
		m.slides:insert(p)
	end
	
	local defaultString = "1 of " .. #m.images

	local navBar = display.newGroup()
	m:insert(navBar)
	
	m.imgNum = 1

	function activate( e )
		print("activate")
		m.isActive = true
	end
	Runtime:addEventListener("slider:closePanel", activate)
	Runtime:addEventListener("slider:activate", activate)

	function playFullLevel( id )
		local event = GameEvent.getEvent(GameEvent.TOUCH, m, false)
		Runtime:dispatchEvent(event)
		_G.activeLevel = _G.levelsData[m.images[id].id]
		
		_G.activeLevelId = m.images[id].id
		_G.activeSet = 1
		_G.restricted = false
		if _G.userData.userProgress[_G.activeLevelId] then _G.activeSet = _G.userData.userProgress[_G.activeLevelId] end
		--audio.playSFX(_G.activeLevel.audio_level_open[_G.lang].audio)

		local aud = audio.loadStream(_G.lang.."_"..m.images[id].id..".mp3")
		audio.play(aud, {onComplete=function() 
				Runtime:dispatchEvent({name="UIEvent", data="game", target=self})
			end})
	end
	
	function gameSelected(id)
		m.isActive = false
		print("selected: " .. id)
		analytics.logEvent("MainMenu Click "..m.images[id].id)

		if m.images[id].action == "play" then
			if _G.textBox then _G.textBox.print("Play full level: "..m.images[id].id) end
			playFullLevel(id)

		elseif m.images[id].action == "iap" then
			if _G.userData.iap[m.images[id].productIdSingle] then
				if _G.textBox then _G.textBox.print("Play unlocked level: "..m.images[id].id) end
				playFullLevel(id)
			else--show upgrade
				audio.playSFX("sfx_button_click_generic.wav")
				m.images[id]:showUpgrade()
				m.isActive = false
			end

		elseif m.images[id].action == "url" then
			system.openURL(m.images[id].actionData)
			m.isActive = true

		else 
			m.isActive = true
		end
	end
	
			
	function touchListener (self, touch) 
		local phase = touch.phase
		--print("m.slides", phase)
		if ( phase == "began" ) then
            -- Subsequent touch events will target button even if they are outside the contentBounds of button
            display.getCurrentStage():setFocus( self )
            self.isFocus = true

			m.startPos = touch.x
			m.prevPos = touch.x
			
			m.images[m.imgNum].tween = transition.to(m.images[m.imgNum], {time=100, xScale=0.99, yScale=0.99})
			
			
									
        elseif( self.isFocus ) then
        
			if ( phase == "moved" ) then
			
				--transition.to(navBar,  { time=400, alpha=0 } )
						
				if tween then transition.cancel(tween) end
	
				--print(m.imgNum)
				if m.isDrag then
					local delta = touch.x - m.prevPos
					m.prevPos = touch.x
					m.slides.x = m.slides.x + delta
				else
					m.dragDistance = touch.x - m.startPos
					if m.dragDistance < -dragTolerance or m.dragDistance > dragTolerance  then
					 m.isDrag = true
					end
				end

			elseif ( phase == "ended" or phase == "cancelled" ) then
				if m.images[m.imgNum].tween then transition.cancel(m.images[m.imgNum].tween) end
				m.images[m.imgNum].tween = transition.to(m.images[m.imgNum], {time=100, xScale=1, yScale=1})
				
				m.dragDistance = touch.x - m.startPos
				--print("m.dragDistance: " .. m.dragDistance)
				print("imgNumb: " .. m.imgNum)
				if (m.dragDistance < -40 and m.imgNum < #m.images) then
					nextImage()
				elseif (m.dragDistance > 40 and m.imgNum > 1) then
					prevImage()
				else
					cancelMove()
				end
									
				if ( phase == "cancelled" ) then
					cancelMove()
				end
				
				if m.isDrag == false and m.isActive == true then		
					m.isActive = false
					if m.images[m.imgNum].tween then 
						transition.cancel(m.images[m.imgNum].tween)	
					end
					m.images[m.imgNum].tween = transition.to(m.images[m.imgNum], {time=100, xScale=1, yScale=1, onComplete=function() gameSelected(m.imgNum) end})
				end
				m.isDrag = false
				
                display.getCurrentStage():setFocus( nil )
                self.isFocus = false						
			end
		end
					
		return true
		
	end
	
	function addTouchEvent()
		m.images[m.imgNum].touch = touchListener
		m.images[m.imgNum]:addEventListener( "touch", m.images[m.imgNum] )
	end
	
	function removeTouchEvent()
		if m.images[m.imgNum] then
			m.images[m.imgNum]:removeEventListener( "touch", m.images[m.imgNum] )
			m.images[m.imgNum].touch = nil
		end
	end
	
	function setSlideNumber()
		print("setSlideNumber", m.imgNum .. " of " .. #m.images)
		
	end
	
	function initImage(num)
		addTouchEvent()
		setSlideNumber()
		--close panels
		Runtime:dispatchEvent({name="slider:closeIAP", target=m})
		m.isActive = true
	end
	
	function cancelTween()
		if prevTween then 
			transition.cancel(prevTween)
		end
		prevTween = tween 
	end
	
	function nextImage()
		removeTouchEvent()
		m.imgNum = m.imgNum + 1
		tween = transition.to(m.slides, {time=slideTime, x=-m.images[m.imgNum].ox, transition=easing.outQuad})
		initImage(m.imgNum)
	end
	
	function prevImage()
		removeTouchEvent()
		m.imgNum = m.imgNum - 1
		tween = transition.to(m.slides, {time=slideTime, x=-m.images[m.imgNum].ox, transition=easing.outQuad})
		
		initImage(m.imgNum)
	end
	
	function cancelMove()
		tween = transition.to(m.slides, {time=slideTime, x=-m.images[m.imgNum].ox, transition=easing.outQuad})
		
	end

	--m.slides.touch = touchListener
	--m.slides:addEventListener( "touch", m.slides )
	--
	addTouchEvent()
	------------------------
	-- Define public methods
	
	function m:jumpToImage(num)
		local i
		print("jumpToImage")
		print("#images", #self.images)
		--images[num].x = - images[m.imgNum].ox
		self.slides.x = self.slides.x - self.images[num].x
		
		self.imgNum = num
		initImage(self.imgNum)
	end
	
	function m:nextSlide()
		if self.imgNum < #self.images then
			nextImage()
		end
	end
	
	function m:previousSlide()
		if self.imgNum > 1 then
			prevImage()
		end
	end
	
	--goto proper teaser image
	for i=1, #m.images do
		if m.images[i].id == _G.appID then m:jumpToImage(i); break; end
	end
	
	
	m.oldRemoveSelf = m.removeSelf
	function m:removeSelf()
		self.slides:removeEventListener("slider:closePanel", activate)
		self.images[self.imgNum]:removeEventListener( "touch", self.images[self.imgNum] )
		self.images[self.imgNum].touch = nil

		for i,v in ipairs(self.images) do
			v:removeSelf()
		end
		self.images = nil
		
		self:oldRemoveSelf()
		self = nil
		print("Slider Destroyed")
	end

	return m
end

return Slider

