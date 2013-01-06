local GameSelect = {}

local BlerdoButton = require "BlerdoButton"

GameSelect.new = function(menuItem)
	-- functions
	local construct
	local closePanel
	local onSliderTouch
	local showBuyPanel
	local decorateBuyButtons
	local decorateLinkButtons
	local activate
	local changeLanguage
	local addIapLabels
	local removeIapLabels
	local addIapSelectLabels
	local removeIapSelectLabels
	
	local m = display.newGroup()
	m.active = true
	m.image = menuItem.teaserImage
	m.thumbnailImage = menuItem.thumbnailImage
	m.thumbnailAllImage = menuItem.thumbnailAllImage
	m.caption = nil
	m.id = menuItem.id
	m.action = menuItem.action
	m.actionData = menuItem.actionData
	m.productIdSingle = menuItem.productIdSingle
	m.title = nil

	function activate( event )
		m.active = true
	end
	Runtime:addEventListener("slider:activate", activate)
	
	--CONSTRUCTOR
	function construct()
		m.bgImage = display.newImageRect(m.image, 190, 110, "tl")
		m.bgImage:setPos(-97,-74)
		m:insert(m.bgImage)
		
		m.frame = display.newImageRect("main_game_select.png", 220, 176)
		m.frame:setPos(0,0)
		m:insert(m.frame)
		
		--title

		m.iap = display.newGroup()
		m:insert(m.iap)
		
		m.iap.overlay = display.newImageRect("main_game_select_overlay.png", 220, 176)
		m.iap.overlay:setPos(0,0)
		m.iap:insert(m.iap.overlay)
		
		m.iap.playBtn = BlerdoButton.newAdvBtn({normal="main_btn_play.png", normalWidth=189, normalHeight=69, over="main_btn_play_down.png", overWidth=189, overHeight=69})
		m.iap.playBtn:setPos(-95, -69)
		m.iap.playBtn._onRelease = function() 
			if m.active then
				m.active = false
				print("play touched")
				analytics.logEvent("iap_play_click")

				if _G.textBox then _G.textBox.print("Play restricted level: "..m.id) end

				local event = GameEvent.getEvent(GameEvent.TOUCH, m, false)
				Runtime:dispatchEvent(event)
				_G.activeLevel = _G.levelsData[m.id]
				
				_G.activeLevelId = m.id
				_G.activeSet = 1
				_G.restricted = true
				if _G.userData.userProgress[_G.activeLevelId] and _G.userData.userProgress[_G.activeLevelId] < 3 then _G.activeSet = _G.userData.userProgress[_G.activeLevelId] end
				--audio.playSFX(_G.activeLevel.audio_level_open[_G.lang].audio)

				local aud = audio.loadStream(_G.lang.."_"..m.id..".mp3")
				print("i am looking for: ".._G.lang.."_"..m.id..".mp3")
				print("before audio play")
				audio.play(aud, {onComplete=function() 
						print("after the soud")
						Runtime:dispatchEvent({name="UIEvent", data="game", target=self})
					end})
			end 
		end
		m.iap:insert(m.iap.playBtn)

		--play
		--2levels
		
		m.iap.slideBg = display.newImageRect("main_btn_slide.png", 189, 69, "tl")
		m.iap.slideBg:setPos(-95, -1)
		m.iap:insert(m.iap.slideBg)
		
		

		m.iap.slider = display.newImageRect("main_btn_slider.png", 42, 42, "tl")
		m.iap.slider:setPos(-81, 10)
		m.iap:insert(m.iap.slider)
		m.iap.slider.startX = m.iap.slider.x
		m.iap.slider.endX = m.iap.slider.x + 115
		m.iap.slider.onRelease = showBuyPanel
		m.iap.slider.touch = onSliderTouch --[[function ( self, event )
			if event.phase == "began" then
				if m.active then
					m.active = false
					showBuyPanel()
				end
			end
		end--]]
		m.iap.slider:addEventListener("touch", m.iap.slider)

		--[[
		m.iap.closeBtn = display.newImageRect("close_button.png", 28, 28)
		m.iap.closeBtn:setPos(98, -78)
		m.iap:insert(m.iap.closeBtn)
		m.iap.closeBtn.touch = closePanel
		m.iap.closeBtn:addEventListener("touch", m.iap.closeBtn)
		--]]
		addIapLabels()


		m.iap.isVisible = false

		--[
		m.iapSelect = display.newGroup()
		m:insert(m.iapSelect)
		
		m.iapSelect.overlay = display.newImageRect("main_game_select_overlay.png", 220, 176)
		m.iapSelect.overlay:setPos(0, 0)
		m.iapSelect:insert(m.iapSelect.overlay)
		
		m.iapSelect.buyBundleBtn = BlerdoButton.newAdvBtn({normal="main_btn_generic.png", normalWidth=189, normalHeight=69, over="main_btn_generic_down.png", overWidth=189, overHeight=69})
		m.iapSelect.buyBundleBtn:setPos(-95, -69)
		m.iapSelect:insert(m.iapSelect.buyBundleBtn)
		
		m.iapSelect.bundlePriceText = display.newText("", 0, 0, _G.fonts.boris, 12, "c")
		blerdo.rescaleText(m.iapSelect.bundlePriceText, 180)
		m.iapSelect.bundlePriceText:setTextColor("#342d3a")
		m.iapSelect.bundlePriceText:setPos(27, -30)
		m.iapSelect:insert(m.iapSelect.bundlePriceText)
		
		m.iapSelect.thumbAll = display.newImageRect(m.thumbnailAllImage, 58, 39)
		m.iapSelect.thumbAll:setPos(-53, -38)
		m.iapSelect:insert(m.iapSelect.thumbAll)



		m.iapSelect.buySetBtn = BlerdoButton.newAdvBtn({normal="main_btn_generic.png", normalWidth=189, normalHeight=69, over="main_btn_generic_down.png", overWidth=189, overHeight=69})
		m.iapSelect.buySetBtn:setPos(-95, -1)
		m.iapSelect:insert(m.iapSelect.buySetBtn)
		
		m.iapSelect.setPriceText = display.newText("", 0, 0, _G.fonts.boris, 12, "c")
		blerdo.rescaleText(m.iapSelect.setPriceText, 180)
		m.iapSelect.setPriceText:setTextColor("#342d3a")
		m.iapSelect.setPriceText:setPos(27, 37)
		m.iapSelect:insert(m.iapSelect.setPriceText)
		
		m.iapSelect.thumbSingle = display.newImageRect(m.thumbnailImage, 58, 39)
		m.iapSelect.thumbSingle:setPos(-53, 33)
		m.iapSelect:insert(m.iapSelect.thumbSingle)

		m.iapSelect.closeBtn = display.newImageRect("close_button.png", 28, 28)
		m.iapSelect.closeBtn:setPos(98, -78)
		m.iapSelect:insert(m.iapSelect.closeBtn)
		m.iapSelect.closeBtn.touch = closePanel
		m.iapSelect.closeBtn:addEventListener("touch", m.iapSelect.closeBtn)


		
		addIapSelectLabels()


		m.iapSelect.isVisible = false

		--]]

	end


	function addIapLabels(  )
		m.title = display.newText(_G.rosetta:getString(menuItem.id.."_label"), 0, 53, _G.fonts.boris, 14)
		m.title:setTextColor("#342d3a")
		m:insert(3, m.title)

		m.iap.playText = display.newText(rosetta:getString("play_label"), 0, 0, _G.fonts.boris, 25, "c")
		blerdo.rescaleText(m.iap.playText, 170)
		m.iap.playText:setTextColor("#342d3a")
		m.iap.playText:setPos(-27, -43)
		m.iap:insert(m.iap.playText)

		m.iap.freeText = display.newText(rosetta:getString("twofreelevels_label"), 0, 0, _G.fonts.boris, 8, "c")
		blerdo.rescaleText(m.iap.freeText, 160)
		m.iap.freeText:setTextColor("#342d3a")
		m.iap.freeText:setPos(-32, -24)
		m.iap:insert(m.iap.freeText)

		m.iap.fullText = display.newText(rosetta:getString("iap_fullversion_label"), 0, 0, _G.fonts.boris, 12, "c")
		blerdo.rescaleText(m.iap.fullText, 212)
		m.iap.fullText:setTextColor("#342d3a")
		m.iap.fullText:setPos(17, 25)
		m.iap:insert(m.iap.fullText)
		
		m.iap.upgradeText = display.newText(rosetta:getString("iap_swipe_to_unlock_label"), 0, 0, _G.fonts.boris, 8, "c")
		blerdo.rescaleText(m.iap.upgradeText, 176)
		m.iap.upgradeText:setTextColor("#342d3a")
		m.iap.upgradeText:setPos(17, 37)
		m.iap:insert(m.iap.upgradeText)

		--bring slider to front
		m.iap:insert(m.iap.slider)
	end

	function removeIapLabels(  )
		print("try to remove: "..m.id)
		print(m.title.text)
		m.title:removeSelf()
		m.iap.playText:removeSelf()
		m.iap.freeText:removeSelf()
		m.iap.fullText:removeSelf()
		m.iap.upgradeText:removeSelf()
	end

	function addIapSelectLabels(  )
		m.iapSelect.bundleText = display.newText(rosetta:getString("iap_fullversion_label"), 0, 0, _G.fonts.boris, 12, "c")
		blerdo.rescaleText(m.iapSelect.bundleText, 190)
		m.iapSelect.bundleText:setTextColor("#342d3a")
		m.iapSelect.bundleText:setPos(27, -43)
		m.iapSelect:insert(m.iapSelect.bundleText)
		
		m.iapSelect.setText = display.newText(rosetta:getString(menuItem.id.."_label"), 0, 0, _G.fonts.boris, 12, "c")
		blerdo.rescaleText(m.iapSelect.setText, 190)
		m.iapSelect.setText:setTextColor("#342d3a")
		m.iapSelect.setText:setPos(27, 25)
		m.iapSelect:insert(m.iapSelect.setText)
		
	end

	function removeIapSelectLabels(  )
		m.iapSelect.bundleText:removeSelf()
		m.iapSelect.setText:removeSelf()
	end


	function onSliderTouch( self, event )
		local phase = event.phase

		if "began" == phase then
			if self.tween then transition.cancel(self.tween) end
			self.unlocked = false
			
			audio.playSFX("sfx_button_click_generic.wav");
			self.prevX = event.x

			-- Subsequent touch events will target button even if they are outside the contentBounds of button
			display.getCurrentStage():setFocus( self, event.id )
			self.isFocus = true
			
		elseif self.isFocus then

			if "moved" == phase then
				self.x = event.x - self.prevX + self.startX
				if self.x <= self.startX then self.x = self.startX end
				if self.x >= self.endX then
					self.x = self.endX
					m.iap.slider:removeEventListener("touch", m.iap.slider)
					display.getCurrentStage():setFocus( self, nil )
					self.isFocus = false
					print("UNLOCKED")
					audio.playSFX("sfx_button_click_generic.wav");
					m.active = false
					timer.performWithDelay(200, function( event )
						self.onRelease()
					end, 1) 
				end
				
			elseif "ended" == phase or "cancelled" == phase and not self.unlocked then
				self.tween = transition.to(self, {time=200, x=self.startX})
				
				-- Allow touch events to be sent normally to the objects they "hit"
				display.getCurrentStage():setFocus( self, nil )
				self.isFocus = false
			end
		end

		return true
	end

	function decorateBuyButtons( event )
		if _G.textBox then _G.textBox.print("decorate buttons with iap prices") end

		m.iapSelect.buyBundleBtn._onRelease = function() --IAP buy
			if m.active then
				native.setActivityIndicator( true )
				m.active = false
				print("buy bundle");
				analytics.logEvent("iap_selected_".._G.preferencesData.productIdBundle)
				_G.iap:buyProduct(_G.preferencesData.productIdBundle) 
			end
		end
		m.iapSelect.buySetBtn._onRelease = function() -- IAP buy
			if m.active then
				native.setActivityIndicator( true )
				m.active = false
				print("buy single set");
				analytics.logEvent("iap_selected_"..m.productIdSingle)
				_G.iap:buyProduct(m.productIdSingle)
			end
		end

		if store.availableStores.apple then
			for i=1, #event.products do
				local currentItem = event.products[i]
				if currentItem.productIdentifier == _G.preferencesData.productIdBundle then
					m.iapSelect.bundlePriceText.text = currentItem.localizedPrice
					print("Bundle price: ".. currentItem.localizedPrice)
				else
					m.iapSelect.setPriceText.text = currentItem.localizedPrice
					print("Set price: ".. currentItem.localizedPrice)
				end
			end
		else
			m.iapSelect.bundlePriceText.text = _G.rosetta:getString("iap_price_placeholder")
			m.iapSelect.setPriceText.text = _G.rosetta:getString("iap_price_placeholder")
			if not m.iapSelect.bundlePriceText.scaled then blerdo.rescaleText(m.iapSelect.bundlePriceText, 180); m.iapSelect.bundlePriceText.scaled=true  end
			if not m.iapSelect.setPriceText.scaled then blerdo.rescaleText(m.iapSelect.setPriceText, 180); m.iapSelect.setPriceText.scaled = true end
		end
		m.active = true
		native.setActivityIndicator( false )
	end

	function decorateLinkButtons( )
		if _G.textBox then _G.textBox.print("decorate buttons with links") end

		m.iapSelect.buyBundleBtn._onRelease = function() --IAP buy
			if m.active then
				print("buy bundle")
				analytics.logEvent("iap_fallback_link_click")
				system.openURL(menuItem.fallbackUrlBundle)
			end
		end
		m.iapSelect.buySetBtn._onRelease = function() -- IAP buy
			if m.active then
				print("buy set")
				analytics.logEvent("iap_fallback_link_click")
				system.openURL(menuItem.fallbackUrlSingle)
			end
		end
		
		m.iapSelect.bundlePriceText.text = _G.rosetta:getString("iap_price_placeholder")
		m.iapSelect.setPriceText.text = _G.rosetta:getString("iap_price_placeholder")
		if not m.iapSelect.bundlePriceText.scaled then blerdo.rescaleText(m.iapSelect.bundlePriceText, 180); m.iapSelect.bundlePriceText.scaled=true  end
		if not m.iapSelect.setPriceText.scaled then blerdo.rescaleText(m.iapSelect.setPriceText, 180); m.iapSelect.setPriceText.scaled = true end

		--TODO decorate with links
		m.active = true
	end

	function showBuyPanel( )
		analytics.logEvent("iap_slider_activated")
		if _G.internet and store.canMakePurchases then
			analytics.logEvent("iap_check_ok")
			native.setActivityIndicator( true )
			local listOfProducts = {
				m.productIdSingle,
				_G.preferencesData.productIdBundle
			}
			if store.canLoadProducts then 
				store.loadProducts( listOfProducts, decorateBuyButtons )
			else
				decorateBuyButtons()
			end
		else
			analytics.logEvent("iap_check_failed")
			decorateLinkButtons()
		end
		m.iap.isVisible = false
		m.iapSelect.isVisible = true
		m.iap.slider.x = m.iap.slider.startX
		m.iap.slider:addEventListener("touch", m.iap.slider)
		m.active = true
	end


	function closePanel( self, event )
		if event.phase == "began" then
			audio.playSFX("sfx_button_click_generic.wav");
			if m.active then
				m.iapSelect.isVisible = false
				m.iap.isVisible = true
			end
		end
		return true
	end

	function closeAll( event )
		m.iap.isVisible = false
		m.iapSelect.isVisible = false
		m.active = true
	end
	Runtime:addEventListener("slider:closeIAP", closeAll)

	function changeLanguage( )
		removeIapLabels()
		removeIapSelectLabels()
		addIapLabels()
		addIapSelectLabels()
		--if m.iapSelect.isVisible then showBuyPanel() end
	end
	Runtime:addEventListener("settings:change.language", changeLanguage)

	function m:showUpgrade( )
		--print("show upgrade")
		m.iap.isVisible = true
	end
	
	-- DESTRUCTOR	
	m.oldRemoveSelf = m.removeSelf
	function m:removeSelf()
		Runtime:removeEventListener("settings:change.language", changeLanguage)
		Runtime:removeEventListener("slider:closeIAP", closeAll)
		
		self:oldRemoveSelf()
		print ("GameSelect panel ".. self.image .." destroyed")
		self = nil
	end
	
	construct()
	return m
end

return GameSelect