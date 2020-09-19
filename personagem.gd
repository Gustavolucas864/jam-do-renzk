extends KinematicBody2D

var direcao = Vector2()
var velocidade = 200
var pode_controlar = true

var posicoes = []
var quantidade_posicoes = 70
var estado = 0 #0: sem efeito, 1: coletando para dps voltar as posicoes
var contador_posicao = quantidade_posicoes


func _ready():
	$"Timer".start(0.1)


func _process(delta):
	
	if pode_controlar:
		direcao.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		direcao.y =  Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	
	if Input.is_action_just_pressed("ui_select"):
		estado = 1
	
	move_and_slide(direcao * velocidade)


func _on_Timer_timeout():
	if estado == 1:
		if posicoes.size() >= quantidade_posicoes:
			pode_controlar = false
			direcao = Vector2()
			print("voltando")
			self.global_position = posicoes[contador_posicao] #volta para a posicao da lista selecionada
			contador_posicao -= 1 #vai reduzindo o indice das posicoes ate chegar no 0, que é a posicao inicial
			$"Timer".wait_time = 0.03 #intervalo de tempo entre cada retrocesso de posicao
			if contador_posicao <= -1 : #termian o mecanismo de volta das posicoes
				pode_controlar = true
				estado = 0
		else:
			print("armazenando")
			$"Timer".wait_time = 0.08 #intervalo de tempo entre cada armazenada
			posicoes.append(self.global_position) #vai adicionando as posicoes
			print("adicionando: ", self.global_position)
			contador_posicao = posicoes.size() -1 #vai atualizando o indice da ultima posicao
	else:
		posicoes.clear()
		contador_posicao = 0























