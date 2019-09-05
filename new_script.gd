extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



	if message == 1:
		$Instruction.text = instruction[message]
		$IndiceArea.text = "Appuyez ici ou en bas pour fermer l'indice, puis flèche de droite."
		$Left.disabled = true
	if message == 2:
		$Instruction.text = "Bienvenue au jeu de la chasse aux trésors !"
		$IndiceArea.text = "Aucun indice disponible."
	if message == 3:
		$Instruction.text = "Des oeufs au chocolat ont été cachés dans la médiathèque, pour les retrouver [...]"
		$IndiceArea.text = "Aucun indice disponible."
	if message == 4:
		$Instruction.text = "[...] des énigmes et indices vont vous être donnés."
		$IndiceArea.text = "Aucun indice disponible."
		$Answer.visible = false
	if message == 5:
		$Instruction.text = "Donnez les réponses sans majuscules."
		$IndiceArea.text = "Aucun indice disponible."
		$Answer.visible = false
	if message == 6:
		$Instruction.text = "Question 1: que font 2+2 ?"
		$IndiceArea.text = "Use the force Luke!"
		$Answer.visible = true
		$SideMenu.visible = true
		
		$Camera1/Travelling.play("Path1")
		
		if forcedCam == false:
			$Camera1.current = true
			forcedCam = true
		
		if answer1Correct == true:
			$Answer.disabled = true
			$Answer.text = "Répondu"
		else:
			$Answer.disabled = false
			$Answer.text = "Répondre"
		
	if message == 7:
		$Instruction.text = "Question 2: quelle est la couleur du cheval blanc de Henri IV ?"
		$IndiceArea.text = "Couleur."
		$Answer.visible = true
		$Camera1/Travelling.play("Path2")
		
		if answer2Correct == true:
			$Answer.disabled = true
			$Answer.text = "Répondu"
		else:
			$Answer.disabled = false
			$Answer.text = "Répondre"
	
	if message == 8:
		$Instruction.text = "Question 3: quelle est le diminutif de Villeneuve Saint-Georges ?"
		$IndiceArea.text = "Couleur."
		$Answer.visible = true
		
		if answer3Correct == true:
			$Answer.disabled = true
			$Answer.text = "Répondu"
		else:
			$Answer.disabled = false
			$Answer.text = "Répondre"
			
	if message == 9:
		$Instruction.text = "Bravo !"
		$IndiceArea.text = "The cake wasn't a lie!"
		$Answer.visible = false








	if message == questionStart:
		if $GiveAnswer.get_text() == answer1:
			$CheckAnswer.text = "Bonne réponse !"
			answer1Correct = true
			lock += 1
			
			$CheckAnswer.margin_top = -300
			$CheckAnswer.margin_bottom = 100

		else:
			$CheckAnswer.text = "Mauvaise réponse"
			
			$CheckAnswer.margin_top = -450
			$CheckAnswer.margin_bottom = -220

	if message == questionStart+1:
		if $GiveAnswer.get_text() == answer2:
			$CheckAnswer.text = "Bonne réponse !"
			answer2Correct = true
			lock += 1
			
			$CheckAnswer.margin_top = -300
			$CheckAnswer.margin_bottom = 100
		else:
			$CheckAnswer.text = "Mauvaise réponse"
			
			$CheckAnswer.margin_top = -450
			$CheckAnswer.margin_bottom = -220
	
	if message == questionStart+2:
		if $GiveAnswer.get_text() == answer3:
			$CheckAnswer.text = "Bonne réponse !"
			answer3Correct = true
			lock += 1
			
			$CheckAnswer.margin_top = -300
			$CheckAnswer.margin_bottom = 100
		else:
			$CheckAnswer.text = "Mauvaise réponse"
			
			$CheckAnswer.margin_top = -450
			$CheckAnswer.margin_bottom = -220