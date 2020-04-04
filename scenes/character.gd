extends KinematicBody

var gravity = -9.8
var velocity = Vector3()
var camera
var animation_player
var character

const SPEED = 5
const ACCELARATION = 3
const DE_ACCELARATION = 5 

func _ready():
	animation_player = get_node("AnimationPlayer")
	character = get_node(".")

func _physics_process(delta):
	checkBounds()
	camera = get_node("target/Camera").get_global_transform()
	var direction = Vector3()
	var is_moving = false
	
	if(Input.is_action_pressed("move_forward")):
		direction += -camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_backward")):
		direction += camera.basis[2]
		is_moving = true
	if(Input.is_action_pressed("move_left")):
		direction += -camera.basis[0]
		is_moving = true
	if(Input.is_action_pressed("move_right")):
		direction += camera.basis[0]
		is_moving = true
	
	direction.y = 0
	direction = direction.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = direction * SPEED
	var accel = DE_ACCELARATION
	
	if(direction.dot(hv) > 0):
		accel = ACCELARATION
		
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	if is_moving:
		var angle = atan2(hv.x, hv.z)
		var character_rotation = character.get_rotation()
		character_rotation.y = angle
		character.set_rotation(character_rotation)
		
	
	var next_animation = "idle"
	
	if is_moving:
		next_animation = "run"
	
	if next_animation != animation_player.get_current_animation():
		animation_player.play(next_animation)
	
func checkBounds():
	if transform.origin.y < -2:
		$"/root/global".emit_signal("game_over")
	
	
	
	
	