-- www.davebollinger.org
-- SimpleBitmapFont Demo

display.setStatusBar( display.HiddenStatusBar )

-- optional but recommended (if using as expected)
display.setDefault("minTextureFilter", "nearest")
display.setDefault("magTextureFilter", "nearest")


local SimpleBitmapFont = require("lib.SimpleBitmapFont")

display.setDefault("background", 0.2, 0.4, 0.6)
local texts = {}
local tx = display.contentCenterX
local ty, tdy = 50, 20


local font16x32 = SimpleBitmapFont:new({
	filename = "img/font16x32.png",
	charWidth = 16,
	charHeight = 32,
	firstChar = 32,
	numChars = 96,
	sheetContentWidth = 256,
	sheetContentHeight = 192
})
texts[#texts+1] = font16x32:newText({ text="SimpleBitmapFont", x=tx, y=ty })
ty = ty + 40


local font8x14 = SimpleBitmapFont:new({
	filename = "img/font8x14.png",
	charWidth = 8,
	charHeight = 14,
	firstChar = 32,
	numChars = 64,
	sheetContentWidth = 128,
	sheetContentHeight = 56
})
texts[#texts+1] = font8x14:newText({ text="SIMPLE BITMAP FONT DEMO", x=tx, y=ty })
ty = ty + tdy


local font8x16 = SimpleBitmapFont:new({
	filename = "img/font8x16.png",
	charWidth = 8,
	charHeight = 16,
	firstChar = 32,
	numChars = 96,
	sheetContentWidth = 128,
	sheetContentHeight = 96
})
texts[#texts+1] = font8x16:newText({ text="AbCdEfGhIjKlMnOpQrStUvWxYz0123456789", x=tx, y=ty })
ty = ty + tdy


local thick8x8 = SimpleBitmapFont:new({
	filename = "img/thick8x8.png",
	charWidth = 8,
	charHeight = 8,
	firstChar = 32,
	numChars = 64,
	sheetContentWidth = 128,
	sheetContentHeight = 32
})
texts[#texts+1] = thick8x8:newText({ text="THIS IS THICK8X8, TINTED", x=tx, y=ty })

--
-- NB:  the library itself has no support for "styling", but of course you can DIY:
--

do
	local text = texts[#texts]
	for i = 1, text.numChildren do
		text[i]:setFillColor(1.0,0.6,0.2)
	end
end
ty = ty + tdy

texts[#texts+1] = thick8x8:newText({ text="ALIGNED LEFT", x=0, y=ty, align="left" })
ty = ty + tdy

texts[#texts+1] = thick8x8:newText({ text="ALIGNED RIGHT", x=display.actualContentWidth, y=ty, align="right" })
ty = ty + tdy

local thin8x8 = SimpleBitmapFont:new({
	filename = "img/thin8x8.png",
	charWidth = 8,
	charHeight = 8,
	firstChar = 32,
	numChars = 96,
	sheetContentWidth = 256,
	sheetContentHeight = 24
})
texts[#texts+1] = thin8x8:newText({ text="Thin8x8 Has Lowercase Too.", x=tx, y=ty })
ty = ty + tdy


local tiny4x6 = SimpleBitmapFont:new({
	filename = "img/tiny4x6.png",
	charWidth = 4,
	charHeight = 6,
	firstChar = 32,
	numChars = 64,
	sheetContentWidth = 64,
	sheetContentHeight = 24
})
texts[#texts+1] = tiny4x6:newText({ text="TINY4X6 CAN YOU READ THESE LETTERS?  H M N W", x=tx, y=ty })
ty = ty + tdy

--
-- NB:  the library itself has no support for "animation", but of course you can DIY:
--

local waveH = thick8x8:newText({ text="HORIZONTAL PHRASE WAVE", x=tx, y=ty })
waveH.baseX = waveH.x
ty = ty + tdy
local waveV = thick8x8:newText({ text="VERTICAL CHAR WAVE", x=tx, y=ty })
waveV.baseY = waveV.y
ty = ty + tdy

local t = 0
Runtime:addEventListener("enterFrame", function(e)
	waveH.x = waveH.baseX + 20 * math.cos(t)
	for i = 1, waveV.numChildren do
		waveV[i].y = 8 * math.cos(t+i*0.5)
	end
	t = t + 0.1
end)
