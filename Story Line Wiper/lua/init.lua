_G.StoryLineWiper = _G.StoryLineWiper or {}
StoryLineWiper.ModPath = ModPath

Hooks:Add("LocalizationManagerPostInit", "LocalizationManagerPostInit_SLW", function(loc)
    loc:load_localization_file(StoryLineWiper.ModPath .. "loc/english.json", false)
end)

Hooks:Add("MenuManagerInitialize", "MenuManagerInitialize_SLW", function(menu_manager)
    MenuCallbackHandler.slw_callback_button = function(self, item)
        if item:name() == "slw_wipe_story" then
            StoryLineWiper.showResetDialog()
        end
    end

    MenuHelper:LoadFromJsonFile(StoryLineWiper.ModPath .. "menu/options.json", {}, {})
end)

StoryLineWiper.showResetDialog = function(story_missions_gui)
    local dialog_data = {
        title = managers.localization:text("slw_dialog_title"),
        text = managers.localization:text("slw_dialog_wipe_confirm"),
    }

    local ok_button = {
        text = managers.localization:text("dialog_ok"),
        callback_func = function()
            managers.story:reset_all()
            if story_missions_gui and story_missions_gui._update then
                story_missions_gui:_update()
            end

            StoryLineWiper.showSuccessDialog()
        end,
    }

    local cancel_button = {
        text = managers.localization:text("dialog_cancel"),
        cancel_button = true,
    }

    dialog_data.button_list = {
        ok_button,
        cancel_button,
    }

    managers.system_menu:show(dialog_data)
end

StoryLineWiper.showSuccessDialog = function()
    local dialog_data = {
        title = managers.localization:text("slw_dialog_title"),
        text = managers.localization:text("slw_dialog_wipe_done"),
    }

    local ok_button = {
        text = managers.localization:text("dialog_ok"),
    }

    dialog_data.button_list = {
        ok_button,
    }

    managers.system_menu:show(dialog_data)
end
