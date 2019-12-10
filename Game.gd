extends Control

var message = 1
var maxmessage = 9
var lock = 6
var questionStart = lock
var toggle_instruction = false
var toggle_answer = false

var forcedCam = false
var musicOn = true
var instruction = ["", "Appuyez ici pour avoir un indice.", "Bienvenue au jeu de la chasse aux trésors spécial Tolkien !", "Des oeufs au chocolat ont été cachés dans la médiathèque, pour les retrouver [...]", "[...] des énigmes et indices vont vous être donnés.", "Donnez les réponses sans majuscules.", "Question 1: que font 2+2 ?", "Question 2: quelle est la couleur du cheval blanc de Henri IV ?", "Question 3: quelle est le diminutif de Villeneuve Saint-Georges ?"]
var indice = ["", "Appuyez ici ou en bas pour fermer l'indice, puis flèche de droite.", "Aucun indice disponible.", "Aucun indice disponible.", "Aucun indice disponible.", "Aucun indice disponible.", "Calcul mental.", "Couleur.", "Acronyme"]
var answers = ["", "", "", "", "", "", "4", "blanc", "vsg"]

func _ready():	
	$Left.disabled = true
	$Right.disabled = true
	$ProgressBar.max_value = maxmessage
	$Radar.position.x = OS.window_size.x
	$Radar.position.y = OS.window_size.y - 200
	
	$CheckAnswer.margin_top = -300
	$CheckAnswer.margin_bottom = 100

func _process(delta):
	
	if message == 5:
		pass
	if message == 6:
		pass
		#$Camera1/Travelling.play("Path1")
	if message == 7:
		pass
		#$Camera1/Travelling.play("Path2")
	
	if message == 1:
		$Left.disabled = true
	
	$Instruction.text = instruction[message]
	$IndiceArea.text = indice[message]
	
	if message == lock:
		$Answer.visible = true
	else:
		$Answer.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	$ProgressBar.value = message - 5
		
	if message == lock:
		$Right.disabled = true
		
	if message == maxmessage:
		$Right.disabled = true

func _on_Exit_pressed():
	get_tree().quit()

func _on_Right_pressed():
	if message < maxmessage:
		message += 1
		$Left.disabled = false
	if message == maxmessage:
		$Right.disabled = true

func _on_Left_pressed():
	if message > 1:
		message -= 1
		$Right.disabled = false

func _on_Instruction_pressed():
	if toggle_instruction == false:
		$Left.disabled = true
		$Right.disabled = true
		toggle_instruction = true
		$IndiceArea.visible = true
		$Answer.disabled = true
	else:
		toggle_instruction = false
		$Left.disabled = false
		$Right.disabled = false
		$IndiceArea.visible = false
		$Answer.disabled = false

func _on_IndiceArea_pressed():
	$Instruction.pressed = false
	_on_Instruction_pressed()

func _on_Answer_pressed(): #adjust visibility
	
	$GiveAnswer.text = ""
	
	if toggle_answer == false:		
		$Instruction.disabled = true
		$Left.disabled = true
		$Right.disabled = true
		$GiveAnswer.visible = true
		$ValidAnswer.visible = true
		$ClearAnswer.visible = true
		toggle_answer = true
	else:
		$Instruction.disabled = false
		$Left.disabled = false
		$Right.disabled = false
		$GiveAnswer.visible = false
		$ValidAnswer.visible = false
		$CheckAnswer.visible = false
		$ClearAnswer.visible = false
		toggle_answer = false

func _on_ValidAnswer_pressed():
	$CheckAnswer.visible = true
	if $GiveAnswer.text == answers[message] and message == lock:
		$CheckAnswer.text = "Bonne réponse"
		lock += 1
	else:
		$CheckAnswer.text = "Mauvaise réponse"
	
func _on_CheckAnswer_pressed():	
	if toggle_answer == true:
		$Instruction.disabled = false
		$Left.disabled = false
		$Right.disabled = false
		$GiveAnswer.visible = false
		$ValidAnswer.visible = false
		$CheckAnswer.visible = false
		$ClearAnswer.visible = false
		$Answer.pressed = false
		toggle_answer = false

	$GiveAnswer.text = ""

func _on_ClearAnswer_pressed():
	$GiveAnswer.text = ""

func _on_CheckBox_pressed():
	if musicOn == true:
		$Music.stop()
		musicOn = false
	else:
		$Music.play()
		musicOn = true

func _on_DisplayMap_pressed():
	$Map.visible = true
	$DisableInterface.visible = true

func _on_DisableInterface_pressed():
	$DisableInterface.visible = false
	$Map.visible = false
