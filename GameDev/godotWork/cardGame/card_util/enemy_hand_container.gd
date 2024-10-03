extends HBoxContainer

# A storage box for cards currently in hand by enemy
@onready var enemy = $"../Enemy"

var vec

func _ready():
	init_vec()
	init_self_pos()


func _run_dependencies():
	init_self_size() # dependency: enemy.handsize


# Height / width of a default card
func init_vec():
	vec = (preload("res://assets/CardA.png").get_width() * Global.SCALE)


# set size & pos of CardContainer
func init_self_size():
	self.custom_minimum_size = Vector2(vec[0] * enemy.handsize, vec[1])
	self.size = self.custom_minimum_size


func init_self_pos():
	self.position = Vector2(Global.WINDOW_WIDTH / 2, 0)
