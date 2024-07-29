extends Node


func process_command(input: String):
	var words = input.split(" ", false)
	if words.size() == 0:
		return "error: no words entered."
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
			
	match first_word:
		"go":
			return go(second_word)
		"help":
			return help()
		_:
			return "Unrecognized command."
			
			
			
func go(second_word: String):
	if second_word == "":
		return "Go where?"
		
	return "You go %s" % second_word
	
	
func help():
	return "go {direction}: go to direction entered."
