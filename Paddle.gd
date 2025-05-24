extends Node2D

const SPEED := 300
@export var is_ai := false
# Reference to the ball used only when this paddle is controlled by AI
var ai_target_ball: Node2D

func _process(delta):
    var move := 0.0
    if is_ai and ai_target_ball:
        if ai_target_ball.position.y < position.y:
            move = -1.0
        elif ai_target_ball.position.y > position.y:
            move = 1.0
    else:
        if Input.is_action_pressed("ui_up"):
            move -= 1.0
        if Input.is_action_pressed("ui_down"):
            move += 1.0
    position.y += move * SPEED * delta
    position.y = clamp(position.y, 0.0, get_viewport_rect().size.y)
