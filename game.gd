extends Control


const InputResponse = preload("res://input_response.tscn")
@export var max_lines_remembered = 30

@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var command_processor = $CommandProcessor

func _ready() -> void:
	scrollbar.connect("changed",handle_scrollbar_changed)


func handle_scrollbar_changed():
	self.scrollbar.value=self.scrollbar.max_value


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)	
	history_rows.add_child(input_response)
	
	delete_history_beyond_limit()



func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
