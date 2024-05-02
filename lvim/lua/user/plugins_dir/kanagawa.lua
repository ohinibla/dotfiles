require('kanagawa').setup({
    overrides = function(colors)
        return {
            -- Assign a dynamic color to bookmarked lines by bookmarks.lua plugin hi group
            BookmarkAnnotationLine = { bg = colors.palette.sumiInk4, italic = true },
            BookmarkLine = { bg = colors.palette.sumiInk4, italic = true },
        }
    end,
})

return {
  "rebelot/kanagawa.nvim",
}
