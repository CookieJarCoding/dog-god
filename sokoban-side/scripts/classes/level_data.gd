extends Node2D
class_name LevelData

# Is appended to the main node of a level scene 
# keeps level data that isnt isnt in the grid (sigil queue, name of level, palettes)

var sigil_queue : Array[Level.Sigil]
var level_name : String
var palette : Palette
var palette_dark : Palette
var next_level : String
