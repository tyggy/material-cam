page = new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false
# 	scrollHorizontal: false
	
pagePhoto = new Layer
	width: page.width
	height: page.height
	backgroundColor: "#28affa"
	superLayer: page.content
	
pageVideo = new Layer
	width: page.width
	height: page.height
	backgroundColor: "#40cfc6"
	
page.addPage(pageVideo, "right")

circleA = new Layer
	width: 35
	height: 35
	backgroundColor: "#ffffff"
	borderRadius: 35/2
	opacity: 0.5
	
circleB = new Layer
	width: 35
	height: 35
	backgroundColor: "#ffffff"
	borderRadius: 35/2
	opacity: 0.5
	
circleC = new Layer
	width: 35
	height: 35
	backgroundColor: "#ffffff"
	borderRadius: 35/2

page.content.on "change:x", ->
	circleC.x = Utils.modulate(
		page.content.x,
		[0, -Screen.width],
		[circleA.x, circleB.x], true)


circleA.center()
circleA.centerX(-35)
circleB.center()
circleB.centerX(35)
circleC.center()
circleC.centerX(-35)

shutterSize = 200
shutterVideoSize = shutterSize + 100

shutter = new Layer
	width: shutterSize
	height: shutterSize
	backgroundColor: "#ffffff"
	borderRadius: shutterSize/2

shutter.center()
shutter.centerY(700)

shutter.states.add
	photo:
		x: page.width/2 - shutterSize/2
		width: shutterSize
	video:
		x: page.width/2 - shutterVideoSize/2
		width: shutterVideoSize
		
accentRed = new Layer
	width: 35, height: 35
	backgroundColor: "#ff0000"	
	borderRadius: 35/2
	scale: 0
	
accentRed.center()
accentRed.centerY(700)

accentSize = 160

accentBlue = new Layer
	width: accentSize, height: accentSize
	borderColor: "#28affa"
	borderWidth: 10
	borderRadius: accentSize/2
	backgroundColor: "rgba(0,0,0,0)"

accentBlue.center()
accentBlue.centerY(700) 

accentBlue.states.add
	photo:
		scale: 1
	video:
		scale: 0

Framer.Defaults.Animation = 
	time: 0.3		
		
page.on "change:currentPage", ->
	id = page.horizontalPageIndex(page.currentPage)
	
	accentRed.animate
		properties: 
			scale: id
		curve: "spring(400, 20, 20)"
		
	if id == 1
		shutter.states.switch("video")
		accentBlue.states.switch("video")
	else 
		shutter.states.switch("photo")
		accentBlue.states.switch("photo")