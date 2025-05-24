extends Node2D

const SPEED := 300
@export var is_ai := false
var ball: Node2D

func _process(delta):
    var move := 0.0
    if is_ai and ball:
        if ball.position.y < position.y:
            move = -1.0
        elif ball.position.y > position.y:
            move = 1.0
    else:
        if Input.is_action_pressed("ui_up"):
            move -= 1.0
        if Input.is_action_pressed("ui_down"):
            move += 1.0
    position.y += move * SPEED * delta
    position.y = clamp(position.y, 0.0, get_viewport_rect().size.y)
