extends Node
class_name Health

var _max_val: int
var _val: int

func with_data(v: int):
	_max_val = v
	_val = v
	return self
	
func _ready():
	pass

func val() -> int:
	return _val

func max_val() -> int:
	return _max_val

func reduce(v: int):
	_val -= v
	_val = max(0, _val)

func add(v: int):
	_val += v
	_val = min(_val, _max_val)

func change_max(v: int):
	var old_max = _max_val
	_max_val = v
	_val = min(_val, _max_val)
	_val = max(_val, _val + (_max_val - old_max))
