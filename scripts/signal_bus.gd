extends Node

signal add_item_to_inventory(item: GameItem) #when the player picks and item from the chest
signal item_is_selected(item: GameItem)# When the player selects and item from the item list
signal update_talkbox(message: String) #when there needs to be an update on the user box
signal ping_a_problem() # Each problem that appears on the board will ping the main window to help send the total problems for the graph
signal reset_problem_count() 
signal problem_solved()
signal load_next_scene() #gets the game to load the next scene
signal audio_trigger(type : AudioStream) #sends and audio file to get played
signal activate_exit() #if the user solves all the problem
signal reset_game() #resets the game
signal reset_level() #resets the level
signal try_to_quit_game() #tries to close the game down
signal cue_wind() #cues the wind to play
