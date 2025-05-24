extends Node2D

var score_left := 0
var score_right := 0

@onready var ball := $Ball
@onready var score_label := $ScoreLabel
@onready var left_paddle := $LeftPaddle
@onready var right_paddle := $RightPaddle

func _ready():
    ball.connect("scored", _on_ball_scored)
    right_paddle.is_ai = true
    right_paddle.ball = ball
    _update_score()

func _on_ball_scored(side:String) -> void:
    if side == "left":
        score_left += 1
    else:
        score_right += 1
    _update_score()

func _update_score():
    score_label.text = "%d : %d" % [score_left, score_right]
