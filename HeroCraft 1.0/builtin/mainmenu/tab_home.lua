-- HeroCraft Home Tab
-- Simple and Minecraft-like

return {
	name = "home",
	caption = fgettext("Home"),

	cbf_formspec = function(tabview, name, tabdata)
		local logofile = defaulttexturedir .. "logo.png"
		local bgfile = "default_dirt.png" -- Fallback to dirt if no panorama

		local fs = "formspec_version[3]" ..
			"size[" .. MAIN_TAB_W .. "," .. (MAIN_TAB_H + 1.5) .. "]" ..
			-- Background (Tiled Dirt or Panorama)
			"image[0,0;" .. MAIN_TAB_W .. "," .. (MAIN_TAB_H + 1.5) .. ";" .. bgfile .. "]" ..
			"image[0,0;" .. MAIN_TAB_W .. "," .. MAIN_TAB_H .. ";mcl_gui_background.png]" .. -- Minecraft dark overlay

			-- Logo in center top (Centered horizontally)
			"image[" .. (MAIN_TAB_W / 2 - 3.5) .. ",0.5;7,3.5;" .. core.formspec_escape(logofile) .. "]" ..

			-- Central Buttons (Centered horizontally)
			"style_type[button;font=bold;font_size=18;bgimg=mcl_gui_button.png;bgimg_hovered=mcl_gui_button_hovered.png;content_offset=0,0]" ..
			"button[" .. (MAIN_TAB_W / 2 - 4) .. ",4.2;8,1.0;btn_singleplayer;" .. fgettext("Singleplayer") .. "]" ..
			"button[" .. (MAIN_TAB_W / 2 - 4) .. ",5.3;8,1.0;btn_multiplayer;" .. fgettext("Multiplayer") .. "]" ..
			"button[" .. (MAIN_TAB_W / 2 - 4) .. ",6.4;8,1.0;btn_content;" .. fgettext("HeroCraft Store") .. "]" ..

			-- Bottom Buttons (Centered row)
			"button[" .. (MAIN_TAB_W / 2 - 4.1) .. ",7.5;4,0.9;btn_settings;" .. fgettext("Options...") .. "]" ..
			"button[" .. (MAIN_TAB_W / 2 + 0.1) .. ",7.5;4,0.9;btn_exit;" .. fgettext("Quit HeroCraft") .. "]" ..

			-- Version info at bottom left
			"style[lbl_ver;font=italic;font_size=12;textcolor=#CCCCCC]" ..
			"label[0.3,8.0;HeroCraft " .. core.get_version().string .. "]"

		return fs
	end,

	cbf_button_handler = function(tabview, fields, tabname, tabdata)
		-- Play click sound for any button press
		for k, v in pairs(fields) do
			if k:sub(1, 4) == "btn_" then
				core.sound_play("mcl_sounds_click", { gain = 0.5 })
				break
			end
		end

		if fields.btn_singleplayer then
			tabview:set_tab("local_game")
			return true
		end
		if fields.btn_multiplayer then
			tabview:set_tab("play_online")
			return true
		end
		if fields.btn_content then
			tabview:set_tab("content")
			return true
		end
		if fields.btn_settings then
			local dlg = create_settings_dlg()
			dlg:set_parent(tabview)
			tabview:hide()
			dlg:show()
			return true
		end
		if fields.btn_exit then
			core.close()
			return true
		end
		return false
	end
}


