extends Control

var message = 1
var maxmessage = 9
var lock = 6
var questionStart = lock
var toggle_instruction = false
var toggle_answer = false

var forcedCam = false
var musicOn = true
var easyQuestions = ["", "Appuyez ici pour lire la question.", "Bienvenue au jeu de la chasse aux trésors spécial Tolkien !", "Des anneaux ont été cachés dans la médiathèque, pour les retrouver [...]", "[...] des énigmes et indices vont vous être posés.", "Donnez les réponses sans majuscules.", "Enigme 1", "Question 2: quelle est la couleur du cheval blanc de Henri IV ?", "Question 3: quelle est le diminutif de Villeneuve Saint-Georges ?"]
var hardQuestions = ["", "HARD Appuyez ici pour avoir un indice.", "Bienvenue au jeu de la chasse aux trésors spécial Tolkien !", "Des oeufs au chocolat ont été cachés dans la médiathèque, pour les retrouver [...]", "[...] des énigmes et indices vont vous être donnés.", "Donnez les réponses sans majuscules.", "Question 1: que font 2+2 ?", "Question 2: quelle est la couleur du cheval blanc de Henri IV ?", "Question 3: quelle est le diminutif de Villeneuve Saint-Georges ?"]

var instruction = easyQuestions

var indice = ["", "Appuyez ici ou en bas pour fermer la question, puis flèche de droite.", "Aucune question disponible.", "Aucune question disponible.", "Aucune question disponible.", "Aucune question disponible.", "J’ai les pieds poilus\nLes oreilles pointues\nJe ne suis pas grand\nMais je mange comme un géant", "Couleur.", "Acronyme"]
var answers = ["", "", "", "", "", "", "4", "blanc", "vsg"]

var easy = true

func _ready():
	$Interface.visible = false
	$Interface/Left.disabled = true
	$Interface/Right.disabled = true
	$Interface/ProgressBar.max_value = maxmessage
	
	$CheckAnswer.margin_top = -300
	$CheckAnswer.margin_bottom = 100

func _process(delta):	
	if $CameraAnimation.is_playing() == false:
		$CameraAnimation.play("1")
	
	if message == 5:
		pass
	if message == 6:
		pass
		#$Camera1/Travelling.play("Path1")
	if message == 7:
		pass
		#$Camera1/Travelling.play("Path2")
	
	if message == 1:
		$Interface/Left.disabled = true
	
	$Interface/Instruction.text = instruction[message]
	$Interface/IndiceArea.text = indice[message]
	
	if message == lock:
		$Interface/Answer.visible = true
	else:
		$Interface/Answer.visible = false
	
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	$Interface/ProgressBar.value = message - 5
		
	if message == lock:
		$Interface/Right.disabled = true
		
	if message == maxmessage:
		$Interface/Right.disabled = true

func _on_Exit_pressed():
	get_tree().quit()

func _on_Right_pressed():
	if message < maxmessage:
		message += 1
		$Interface/Left.disabled = false
	if message == maxmessage:
		$Right.disabled = true

func _on_Left_pressed():
	if message > 1:
		message -= 1
		$Interface/Right.disabled = false

func _on_Instruction_pressed():
	if toggle_instruction == false:
		$Interface/Left.disabled = true
		$Interface/Right.disabled = true
		toggle_instruction = true
		$Interface/IndiceArea.visible = true
		$Interface/Answer.disabled = true
	else:
		toggle_instruction = false
		$Interface/Left.disabled = false
		$Interface/Right.disabled = false
		$Interface/IndiceArea.visible = false
		$Interface/Answer.disabled = false

func _on_IndiceArea_pressed():
	$Interface/Instruction.pressed = false
	_on_Instruction_pressed()

func _on_Answer_pressed(): #adjust visibility
	
	$GiveAnswer.text = ""
	
	if toggle_answer == false:		
		$Interface/Instruction.disabled = true
		$Interface/Left.disabled = true
		$Interface/Right.disabled = true
		$GiveAnswer.visible = true
		$ValidAnswer.visible = true
		$ClearAnswer.visible = true
		toggle_answer = true
	else:
		$Interface/Instruction.disabled = false
		$Interface/Left.disabled = false
		$Interface/Right.disabled = false
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
		$Interface/Instruction.disabled = false
		$Interface/Left.disabled = false
		$Interface/Right.disabled = false
		$GiveAnswer.visible = false
		$ValidAnswer.visible = false
		$CheckAnswer.visible = false
		$ClearAnswer.visible = false
		$Interface/Answer.pressed = false
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

func _on_Child_pressed():
	instruction = easyQuestions
	easy = true
	$Difficulty.visible = false
	$Interface.visible = true


func _on_Adult_pressed():
	instruction = hardQuestions
	easy = false
	$Difficulty.visible = false
	$Interface.visible = true
