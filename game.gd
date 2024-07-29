extends Control

const Response = preload("res://response.tscn")
const InputResponse = preload("res://input_response.tscn")
@export var max_lines_remembered = 30

@onready var history_rows = $Background/MarginContainer/Rows/GameInfo/Scroll/HistoryRows
@onready var scroll = $Background/MarginContainer/Rows/GameInfo/Scroll
@onready var scrollbar = scroll.get_v_scroll_bar()
@onready var command_processor = $CommandProcessor

func _ready() -> void:
	scrollbar.connect("changed",handle_scrollbar_changed)
	var starting_message = Response.instantiate()
	add_response_to_game(starting_message)
	starting_message.text = "You awaken in a house with no memory of how you got there. You need to find your way out! Type 'help' to see available commands."


func handle_scrollbar_changed():
	self.scrollbar.value=self.scrollbar.max_value


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	var input_response = InputResponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text, response)	
	add_response_to_game(input_response)
	

func add_response_to_game(response):
	history_rows.add_child(response)
	delete_history_beyond_limit()

func delete_history_beyond_limit():
	if history_rows.get_child_count() > max_lines_remembered:
		var rows_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(rows_to_forget):
			history_rows.get_child(i).queue_free()
