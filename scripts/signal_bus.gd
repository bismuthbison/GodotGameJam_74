extends Node

signal add_item_to_inventory(item: GameItem) #when the player picks and item from the chest
signal item_is_selected(item: GameItem)# When the player selects and item from the item list
signal update_talkbox(message: String) #when there needs to be an update on the user box
signal ping_a_problem() # Each problem that appears on the board will ping the main window to help send the total problems for the graph 
