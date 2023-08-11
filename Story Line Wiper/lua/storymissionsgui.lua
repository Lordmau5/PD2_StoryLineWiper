require("lib/managers/menu/ExtendedUiElemets")

local small_font = tweak_data.menu.pd2_small_font
local small_font_size = tweak_data.menu.pd2_small_font_size

Hooks:PostHook(StoryMissionsGui, "init", "slw_post_StoryMissionsGui__init", function(self, ws, fullscreen_ws, node)
    self._reset_panel = CompositeButton:new(self, {}, {
        input = true,
        w = self._side_scroll:w(),
    })

    self._reset_panel:set_world_top(self._toggle_panel:world_bottom() + 5)
    self._reset_panel:set_world_left(self._side_scroll:world_left())

    self._reset_button = TextButton:new(self._reset_panel, {
        text = managers.localization:text("slw_wipe_story_title"),
        font_size = small_font_size,
        font = small_font,
    }, function()
        StoryLineWiper.showResetDialog(self)
    end)

    self._reset_panel:register_child(self._reset_button)
    self._reset_panel:set_h(self._reset_button:h())

    self._reset_button:set_center_y(self._reset_panel:h() / 2)
    self._reset_button:set_left(5)

    self:_update()
end)
