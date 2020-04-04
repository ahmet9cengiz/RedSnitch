extends KinematicBody

var speed = 2.5
var spin

var velocity

func _ready():
	randomize()
	
func _physics_process(delta):
	spin = rand_range(-0.01, 0.01) 
	rotate_y(lerp(0, spin, 10))
	velocity = Vector3()
	velocity += transform.basis.z * delta * speed
	#if Input.is_action_pressed("ui_accept"):
	move_and_collide(velocity)
	
func _on_walls_body_entered(body):
	rotate_y(180)

func _on_Area_body_entered(body):
	$"/root/global".emit_signal("snitch_catched", self)

func randomizeLocation():
	transform.origin = Vector3(rand_range(-10, 10), 1.45, rand_range(-10, 10))