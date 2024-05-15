if vim.g.neovide then
	vim.opt.linespace = 0
	-- vim.g.neovide_profiler = true
	vim.g.neovide_scale_factor = 0.67
	vim.g.neovide_scroll_animation_length = 0.1
	vim.g.neovide_cursor_animation_length = 0.11 -- 0.13
	vim.g.neovide_cursor_trail_size = 0.2
	vim.g.neovide_cursor_animate_command_line = false
	vim.g.neovide_cursor_vfx_mode = "pixiedust" --	sonicboom, ripple, wireframe, pixiedust
	vim.g.neovide_cursor_vfx_particle_speed = 20.0
	vim.g.neovide_cursor_vfx_opacity = 175.0
	vim.g.neovide_cursor_vfx_particle_lifetime = 1.6
	vim.g.neovide_cursor_vfx_particle_density = 10.0
	vim.g.neovide_show_border = true
end
