extends Control

var message = 1
var lock = 6
var questionStart = lock
var toggle_instruction = false
var toggle_answer = false

var forcedCam = false
var musicOn = true
var instruction = ["", "Appuyez ici pour afficher l'énigme.", "Bienvenue au jeu de la chasse aux trésors spécial Tolkien !", "Des anneaux ont été cachés dans la médiathèque, pour les retrouver [...]", "[...] des énigmes et indices vont vous être posés.", "Donnez les réponses sans majuscules.", "Enigme 1", "Enigme 2", "Enigme 3", "Enigme 4", "Enigme 5", "Enigme 6", "Enigme 7"]

var easyQuestions = ["", "Ici sera affiché l'énigme, appuyez en bas pour fermer cette fenêtre, puis flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "J’ai les pieds poilus\nLes oreilles pointues\nJe ne suis pas grand\nMais je mange comme un géant\n\nQui suis-je ?", "Avec mon chapeau pointu\nEt de mon bâton de mage\nJe dévoile les âmes corrompues\nEt je commande aux orages\n\nQui suis-je ?", "Je suis petit\nJe suis barbu\nJe forge le métal\nA corps perdu\n\nQui suis-je ?", "Je suis vieux et sage\nJe ne fais pas mon âge\nAux autres races je fais mes adieux\nEt m’en vais quitter la Terre du Milieu\n\nQui-suis-je ?", "Mon premier est précieux\nTu poses des questions avec mon second\nMon tout est le nom d’un animal\nMais aussi d’une créature du mal\n\nQui suis-je ?"]
var hardQuestions = ["", "Ici sera affiché l'énigme, appuyez en bas pour fermer cette fenêtre, puis flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Aucune enigme pour le moment, appuyez sur la flèche de droite.", "Dame de Lorién\nAux cheveux d’or et d’argent\nJe siège parmi les sages\nAu Conseil Blanc\n\nQui suis-je ?", "Aux portes de la Moria\nSans moi tu n’entreras point\nMalin qui me trouvera\nEt parlera Ancien\n\n\nQui suis-je ?", "Rôdeur du Nord\nJe commanderai les Morts\nRefleurira l’arbre blanc\nDu Gondor\n\n\nQui suis-je ?"]

var question = easyQuestions

var easyAnswers = ["", "", "", "", "", "", "hobbit", "gandalf", "nain", "elfe", "orque", "dragon", "anneau"]
var hardAnswers = ["", "", "", "", "", "", "galadriel", "meldo", "aragorn", "smaug", "arachne", "balrog", "gollum"]

var answers = easyAnswers

var easy = true

var maxmessage = instruction.size()

func _ready():
	print(instruction.size())
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
	$Interface/IndiceArea.text = question[message]
	
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
	question = easyQuestions
	answers = easyAnswers
	$Difficulty.visible = false
	$Interface.visible = true

func _on_Adult_pressed():
	question = hardQuestions
	answers = hardAnswers
	$Difficulty.visible = false
	$Interface.visible = true
