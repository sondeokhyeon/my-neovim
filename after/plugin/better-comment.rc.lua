local status, betterComment = pcall(require, "better-comment")
if (not status) then return end

betterComment.Setup({
    tags = {
        {
            name = "TODO",
            fg = "white",
            bg = "#0a7aca",
            bold = true,
            virtual_text = "",
        },
        {
            name = "FIX",
            fg = "white",
            bg = "#f44747",
            bold = true,
            virtual_text = "",
        },
        {
            name = "XXX",
            fg = "#FFA500",
            bg = "",
            bold = true,
            virtual_text = "",
        },

    }
})
