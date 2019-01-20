import Foundation
import CMagickWand


var diameter = 640.0
var radius = diameter / 2.0

MagickWandGenesis()

var m_wand = NewMagickWand()
var d_wand = NewDrawingWand()
var c_wand = NewPixelWand()

PixelSetColor(c_wand,"rgb(0,0,1)")
MagickNewImage(m_wand, Int(diameter), Int(diameter), c_wand)


DrawSetStrokeOpacity(d_wand,1)
let image = Image()

// circle and rectangle
PushDrawingWand(d_wand)
// Hmmmm. Very weird. rgb(0,0,1) draws a black line around the edge
// of the circle as it should. But rgb(0,0,0) or black don't.
// AND if I remove the PixelSetColor then it draws a white boundary
// around the rectangle (and presumably around the circle too)
PixelSetColor(c_wand,"rgb(0,0,1)")

DrawSetStrokeColor(d_wand,c_wand)
DrawSetStrokeWidth(d_wand,4)
DrawSetStrokeAntialias(d_wand, MagickTrue)
PixelSetColor(c_wand,"red")
//DrawSetStrokeOpacity(d_wand,1)
DrawSetFillColor(d_wand,c_wand)

// Set up the font size and colour
DrawSetFont(d_wand,"Helvetica")
PixelSetColor(c_wand,"black")
DrawSetFillColor(d_wand,c_wand)
DrawSetFontSize(d_wand,30)
// Now draw the text
DrawAnnotation(d_wand,18,30,"Put your text here")

// same font - different colour and size
PixelSetColor(c_wand,"yellow")
DrawSetFillColor(d_wand,c_wand)
DrawSetFontSize(d_wand,18)
// Now draw the text
DrawAnnotation(d_wand,30,90,"Put more text here")

// same font, size and colour
DrawAnnotation(d_wand,180,90,"Put the third text here")

DrawCircle(d_wand,radius,radius,radius,radius*2)
DrawRectangle(d_wand,50,13,120,87)
PopDrawingWand(d_wand)

// rounded rectangle
PushDrawingWand(d_wand)

var points: [PointInfo] = [PointInfo(x: 378.1, y: 81.72)]

DrawSetStrokeAntialias(d_wand,MagickTrue)
DrawSetStrokeWidth(d_wand,2.016)
DrawSetStrokeLineCap(d_wand,RoundCap)
DrawSetStrokeLineJoin(d_wand,RoundJoin)
DrawSetStrokeDashArray(d_wand, 0, nil)

PixelSetColor(c_wand,/*"#000080"*/"rgb(0,0,128)")
/* If strokecolor is removed completely then the circle is not there */
DrawSetStrokeColor(d_wand,c_wand)
/* But now I've added strokeopacity - 1=circle there  0=circle not there */
/* If opacity is 1 the black edge around the rectangle is visible */
DrawSetStrokeOpacity(d_wand,1)
/* No effect */
//        DrawSetFillRule(d_wand,EvenOddRule)
/* this doesn't affect the circle */
PixelSetColor(c_wand,"#c2c280"/*"rgb(194,194,128)"*/)
DrawSetFillColor(d_wand,c_wand)
//1=circle there 0=circle there but rectangle fill disappears
//		DrawSetFillOpacity(d_wand,0)
DrawPolygon(d_wand,37,points)
//		DrawSetStrokeOpacity(d_wand,1)

PopDrawingWand(d_wand)


/* yellow polygon */
PushDrawingWand(d_wand)
points = [PointInfo(x: 540, y: 288)]
//        {
//            { 540,288 },     { 561.6,216 },   { 547.2,43.2 },  { 280.8,36 },
//            { 302.4,194.4 }, { 331.2,64.8 },  { 504,64.8 },    { 475.2,115.2 },
//            { 525.6,93.6 },  { 496.8,158.4 }, { 532.8,136.8 }, { 518.4,180 },
//            { 540,172.8 },   { 540,223.2 },   { 540,288 }
//    }

DrawSetStrokeAntialias(d_wand,MagickTrue)
DrawSetStrokeWidth(d_wand,5.976)
DrawSetStrokeLineCap(d_wand,RoundCap)
DrawSetStrokeLineJoin(d_wand,RoundJoin)
DrawSetStrokeDashArray(d_wand,0,nil)
PixelSetColor(c_wand,"#4000c2")
DrawSetStrokeColor(d_wand,c_wand)
DrawSetFillRule(d_wand,EvenOddRule)
PixelSetColor(c_wand,"#ffff00")
DrawSetFillColor(d_wand,c_wand)
DrawPolygon(d_wand,15,points)

PopDrawingWand(d_wand)

// rotated and translated ellipse
// The DrawEllipse function only draws the ellipse with
// the major and minor axes orthogonally aligned. This also
// applies to some of the other functions such as DrawRectangle.
// If you want an ellipse that has the major axis rotated, you
// have to rotate the coordinate system before the ellipse is
// drawn. And you'll also want the ellipse somewhere on the
// image rather than at the top left (where the 0,0 origin is
// located) so before drawing the ellipse we move the origin to
// wherever we want the centre of the ellipse to be and then
// rotate the coordinate system by the angle of rotation we wish
// to apply to the ellipse and *then* we draw the ellipse.
// NOTE that doing all this within PushDrawingWand()/PopDrawingWand()
// means that the coordinate system will be restored after
// the PopDrawingWand
PushDrawingWand(d_wand)

PixelSetColor(c_wand,"rgb(0,0,1)")

DrawSetStrokeColor(d_wand,c_wand)
DrawSetStrokeWidth(d_wand,2)
DrawSetStrokeAntialias(d_wand,MagickTrue)
PixelSetColor(c_wand,"orange")
//DrawSetStrokeOpacity(d_wand,1)
DrawSetFillColor(d_wand,c_wand)
// Be careful of the order in which you meddle with the
// coordinate system! Rotating and then translating is
// not the same as translating then rotating
DrawTranslate(d_wand,radius/2,3*radius/2)
DrawRotate(d_wand,-30)
DrawEllipse(d_wand,0,0,radius/8,3*radius/8,0,360)

PopDrawingWand(d_wand)

// A line from the centre of the circle
// to the top left edge of the image
DrawLine(d_wand,0,0,radius,radius)

MagickDrawImage(m_wand,d_wand)
MagickWriteImage(m_wand,"chart_test1.jpg")


c_wand = DestroyPixelWand(c_wand)
m_wand = DestroyMagickWand(m_wand)
d_wand = DestroyDrawingWand(d_wand)

MagickWandTerminus()
