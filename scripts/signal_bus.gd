extends Node

signal add_item_to_inventory(item: GameItem) #when the player picks and item from the chest
signal item_is_selected(item: GameItem)# When the player selects and item from the item list
signal update_talkbox(message: String) #when there needs to be an update on the user box
signal ping_a_problem() # Each problem that appears on the board will ping the main window to help send the total problems for the graph
signal reset_problem_count() #
signal problem_solved()
signal load_next_scene()
signal audio_trigger(type : String)
signal activate_exit()
signal reset_game()
signal reset_level()
signal try_to_quit_game()
