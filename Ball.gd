extends Node2D

signal scored(side)

var velocity := Vector2(-1, 0)
const SPEED := 250

func _ready():
    randomize()
    reset()

func reset():
    position = get_viewport_rect().size / 2
    velocity = Vector2(randf_range(-1, 1), randf_range(-0.5, 0.5)).normalized()

func _process(delta):
    position += velocity * SPEED * delta
    var rect := get_viewport_rect()
    if position.y < 0:
        position.y = 0
        velocity.y = abs(velocity.y)
    elif position.y > rect.size.y:
        position.y = rect.size.y
        velocity.y = -abs(velocity.y)

    if position.x < 0:
        emit_signal("scored", "right")
        reset()
    elif position.x > rect.size.x:
        emit_signal("scored", "left")
        reset()
