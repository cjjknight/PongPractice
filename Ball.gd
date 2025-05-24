extends Node2D

signal scored(side)

var velocity := Vector2(-1, 0)
const SPEED := 250

# Paddles and sprite references for collision checks
@onready var left_paddle = get_parent().get_node("LeftPaddle")
@onready var right_paddle = get_parent().get_node("RightPaddle")
@onready var sprite: Sprite2D = $Sprite

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

    _handle_paddle_collision()

    if position.x < 0:
        emit_signal("scored", "right")
        reset()
    elif position.x > rect.size.x:
        emit_signal("scored", "left")
        reset()

func _handle_paddle_collision():
    var ball_size = sprite.texture.get_size() * sprite.scale
    var ball_rect = Rect2(position - ball_size / 2, ball_size)

    var lp_sprite = left_paddle.get_node("Sprite")
    var lp_size = lp_sprite.texture.get_size() * lp_sprite.scale
    var left_rect = Rect2(left_paddle.position - lp_size / 2, lp_size)
    if ball_rect.intersects(left_rect):
        position.x = left_paddle.position.x + lp_size.x / 2 + ball_size.x / 2 + 1
        velocity.x = abs(velocity.x)
        velocity.y += randf_range(-0.5, 0.5)
        velocity = velocity.normalized()
        return

    var rp_sprite = right_paddle.get_node("Sprite")
    var rp_size = rp_sprite.texture.get_size() * rp_sprite.scale
    var right_rect = Rect2(right_paddle.position - rp_size / 2, rp_size)
    if ball_rect.intersects(right_rect):
        position.x = right_paddle.position.x - rp_size.x / 2 - ball_size.x / 2 - 1
        velocity.x = -abs(velocity.x)
        velocity.y += randf_range(-0.5, 0.5)
        velocity = velocity.normalized()
