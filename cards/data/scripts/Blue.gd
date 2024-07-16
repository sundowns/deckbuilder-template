extends CardBehaviour

var lyrics: String = """---\nYo, listen up, here's the story
About a little guy that lives in a blue world
And all day and all night and everything he sees is just blue
Like him, inside and outside
Blue his house with a blue little window
And a blue Corvette and everything is blue for him
And himself and everybody around
'Cause he ain't got nobody to listen (To listen, to listen, to listen)
"""

@warning_ignore("unused_parameter")
func play(context) -> void:
	print(lyrics)
