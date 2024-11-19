class_name AnimatedPopup
extends PanelContainer


var blur_layer: ColorRect
@export var dismiss_on_click: bool = true:
	set(val):
		dismiss_on_click = val
@export var blur_backgroud_color: Color = Color(Color.WHITE, 0.5):
	set(val):
		blur_backgroud_color = val
		_blur_bg_alpha = val.a
var _max_scale: Vector2 = Vector2(1.1, 1.1)
var _min_scale: Vector2 = Vector2(0.0, 0.0)
var _mid_scale: Vector2 = Vector2(0.5, 0.5)
var _blur_bg_alpha: float = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = _min_scale
	modulate.a = 0
	show()
	_on_change()
	_create_blurred_background()
	move_to_front.call_deferred()


func _create_blurred_background():
	var parent = get_parent()
	blur_layer = ColorRect.new()
	blur_layer.color = blur_backgroud_color
	blur_layer.set_anchors_preset(Control.PRESET_FULL_RECT)
	blur_layer.visible = false
	parent.add_child.call_deferred(blur_layer)
	if dismiss_on_click:
		blur_layer.gui_input.connect(_on_blur_backgroud_clicked)


func _on_blur_backgroud_clicked(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.is_pressed():
				print("Left button was clicked at ", event.position)
				await dismiss()


func _on_change() -> void:
	var parent_size = get_parent_area_size()
	pivot_offset = size / 2
	position = Vector2(parent_size.x / 2 - size.x / 2, parent_size.y / 2 - size.y / 2)
	print_debug(parent_size)


func popup():
	scale = _mid_scale
	var tween = get_tree().create_tween()
	tween.tween_property(blur_layer, "visible", true, 0)
	tween.tween_property(self, "scale", _max_scale, 0.15)
	tween.parallel().tween_property(self, "modulate:a", 1, 0.15)
	tween.parallel().tween_property(blur_layer, "modulate:a", _blur_bg_alpha, 0.15)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2)
	return tween.finished


func dismiss():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "scale", _max_scale, 0.25)
	tween.tween_property(self, "modulate:a", 0, 0.25)
	tween.parallel().tween_property(blur_layer, "modulate:a", 0, 0.25)
	tween.parallel().tween_property(self, "scale", _min_scale, 0.2)
	tween.tween_property(blur_layer, "visible", false, 0)
	return tween.finished
