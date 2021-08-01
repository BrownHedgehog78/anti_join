local storage = minetest.get_mod_storage()
local anti_join_msg = minetest.settings:get("anti_join.msg") or "This server is locked right now. You can't join, please try again later"

minetest.register_on_prejoinplayer(function(name)
	if not minetest.check_player_privs(name, {server = true}) and storage:get_string("anti_join") == "enabled" then
		return anti_join_msg
	end
end)

minetest.register_chatcommand("anti_join", {
	description = "Toggles the anti join",
	privs = {server = true},
	func = function(name)
		if storage:get_string("anti_join") == "enabled" then
			storage:set_string("anti_join", "disabled")
			return false, "Disabled anti join"
		else
			storage:set_string("anti_join", "enabled")
			return false, "Enabled anti join"
		end
	end
})
