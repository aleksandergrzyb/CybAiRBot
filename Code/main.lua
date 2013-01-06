display.setStatusBar(display.HiddenStatusBar)

_W = display.contentWidth
_H = display.contentHeight
_DW = -2 * display.screenOriginX + display.contentWidth
_DH = -2 * display.screenOriginY + display.contentHeight


local storyboard = require "storyboard"
storyboard.purgeOnSceneChange = true
storyboard.gotoScene("blerdoEntry", "fade", 10)