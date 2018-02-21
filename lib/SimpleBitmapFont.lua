--[[
The MIT License (MIT)

SimpleBitmapFont for CoronaSDK
Copyright (c) 2018 David Bollinger
www.davebollinger.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

local SimpleBitmapFont = { __VERSION="1.0.0" }
local SimpleBitmapFont_mt = { __index = SimpleBitmapFont }

---
-- Create a font instance.
-- @param params Table  A table containing the various options needed to create the font:
--   filename String (optional) The filename of the image containing the characters in a regular grid, in ASCII order.  Defaults to "font.png" if not provided.
--   charWidth Number (optional)  The pixel-width of each character in the image.  Defaults to 8 if not provided.
--   charHeight Number (optional)  The pixel-height of each character in the image.  Defaults to 8 if not provided.
--   xSpacing Number (optional)  The horizontal pixel spacing to be used when rendering text.  Defaults to charWidth if not provided.
--   ySpacing Number (optional)  The vertical pixel spacing to be used when rendering text.  Defaults to charHeight if not provided.  (NOT CURRENTLY USED)
--   firstChar Number (optional)  The ASCII value of the first character represented in the image.  Defaults to 32 (space) if not provided.
--   numChars Number (optional)  The number of characters present in the image.  Common values are 64 (uppercase only) and 96 (lowercase also).  Defaults to 64 if not provided.
--   sheetContentWidth Number (optional)  The @1x width of the image.  See graphics.newImageSheet() docs for further info.  Defaults to 128 if not provided.
--   sheetContentHeight Number (optional)  The @1x height of the image.  See graphics.newImageSheet() docs for further info.  Defaults to 32 if not provided.
-- @usage
--   local font = SimpleBitmapFont:new({
--     filename="font8x8.png",
--     charWidth = 8,
--     charHeight = 8,
--     firstChar = 32,
--     numChars = 96,
--     sheetContentWidth = 128,
--     sheetContentHeight = 48
--   })
-- @usage Although all parameters are optional, the default values will only work for a bitmap in exactly the same format as the sample "thick8x8.png".
-- @return Table An font instance with a single method newText()
--
function SimpleBitmapFont:new(params)
	local font = setmetatable( {}, SimpleBitmapFont_mt )
	params = params or {}
	font.filename = params.filename or "font.png"
	font.charWidth = params.charWidth or 8
	font.charHeight = params.charHeight or 8
	font.xSpacing = params.xSpacing or font.charWidth
	font.ySpacing = params.ySpacing or font.charHeight
	font.firstChar = params.firstChar or 32
	font.numChars = params.numChars or 64
	font.sheetContentWidth = params.sheetContentWidth or 128
	font.sheetContentHeight = params.sheetContentHeight or 32
	font.sheetInfo = {
		sheetContentWidth = font.sheetContentWidth,
		sheetContentHeight = font.sheetContentHeight,
		numFrames = font.numChars,
		width = font.charWidth,
		height = font.charHeight
	}
	font.sheet = graphics.newImageSheet(font.filename, font.sheetInfo)
	return font
end

---
-- Renders the specified text.
-- @param params Table A table containing the various options needed to create the text:
--    group DisplayGroup (optional) The DisplayGroup into which the text should be inserted.  Defaults to current stage if not provided.
--    text String (optional) The text string to be rendered.  Defaults to a blank string if not provided (and an empty DisplayGroup will be returned).
--    x Number (optional) The x-coordinate at which to position the DisplayGroup.  Defaults to 0 if not provided.
--    y Number (optional) The y-coordinate at which to position the DisplayGroup.  Defaults to 0 if not provided.
--    align String (option) The alignment of the text relative to 0,0 of the DisplayGroup.  Valid values "left", "center", "right".  Defaults to "center" if not provided.
-- @return DisplayGroup A DisplayGroup containing the specified text, containing individual images for each letter.
-- @usage:
--   local text = font:newText({ text="HELLO", x=100, y=100, align="center" })
--
function SimpleBitmapFont:newText(params)
	params = params or {}
	local text = params.text or ""
	local gx = params.x or 0
	local gy = params.y or 0
	local align = params.align or "center"
	--
	local grp = display.newGroup()
	if (params.group) then params.group:insert(grp) end
	--
	local x = -(#text-1) * self.xSpacing/2  -- default is align center
	if (align=="left") then x = self.xSpacing/2 end
	if (align=="right") then x = -(#text) * self.xSpacing + self.xSpacing/2 end
	local y = 0 -- vertical-alignment not currently supported, always "center"
	for i = 1, #text do
		local chr = text:sub(i,i)
		local idx = string.byte(chr)-self.firstChar+1
		if (idx < 1) or (idx > self.numChars) then idx = 1 end
		local img = display.newImageRect( grp, self.sheet, idx, self.charWidth, self.charHeight)
		img.x = x
		img.y = y
		x = x + self.xSpacing
	end
	--
	grp.x = gx
	grp.y = gy
	return grp
end

return SimpleBitmapFont
-- EOF