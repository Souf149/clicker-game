extends PanelContainer

var characters = []
var index = 0



# Called when the node enters the scene tree for the first time.
func _ready():
	var names = get_file_names("res://classes")
	
	for character in names:
		characters.append({
			imagePath = "res://assets/" + character + "/idle/preview.png",
			className = character
		})
		
	
	loadIndex(0)

func loadIndex(_index):
	index += _index
	
	if index > characters.size() - 1:
		index = 0
	elif index < 0:
		index = characters.size() - 1
	

	$VBoxContainer/className/settingButton/Label.text = characters[index].className
	$VBoxContainer/HBoxContainer2/characterDisplay.texture = load(characters[index].imagePath)

func startGame():
	Global.selectedClass = characters[index].className
	get_tree().change_scene("res://stages/stage1.tscn")

func get_file_names(path):
	var files = []
	var dir = Directory.new()
	dir.open(path)
	dir.list_dir_begin(true)

	var file = dir.get_next()
	while file != '':
		files += [file.split(".")[0]]
		file = dir.get_next()

	return files

