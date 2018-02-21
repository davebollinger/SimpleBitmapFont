# SimpleBitmapFont
A very simple Monospaced Bitmap Font library for Corona SDK

Copyright (C) 2018 David Bollinger
MIT License

Given a bitmap font image, laid out in a regular rectangular
grid, in ASCII order, this library can load that bitmap as
an image sheet and render lines of text with it.

It is intentionally very simple.  It is aimed at rendering
simple single-lines of relatively low-resolution bitmap text
for "retro game" type displays.

There is support for left/center/right horizontal alignment,
but that's about as far as the "fancy" features go...
  No vertical alignment support.
  No multi-line support.
  No "styling" support.
  No "animation" support.

The included demo code does illustrate how you might go about
adding some of these fancier features for yourself, but no
apology is made for them not being part of the base library.
