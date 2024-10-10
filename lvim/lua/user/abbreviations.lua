-- Emoji shortcuts
for _, ab in ipairs({
    {":success:", "✅"},
    {":fail:", "❌"},
    {":thumbs_up:", "👍"},
    {":thumbs_down:", "👎"},
    {":white_check_mark:", "✅"},
    {":warning:", "⚠"},
    {":bulb:", "💡"},
    {":pushpin:", "📌"},
    {":bomb:", "💣"},
    {":pill:", "💊"},
    {":construction:", "🚧"},
    {":pencil:", "📝"},
    {":point_right:", "👉"},
    {":book:", "📖"},
    {":link:", "🔗"},
    {":wrench:", "🔧"},
    {":info:", "🛈"},
    {":telephone:", "📞"},
    {":email:", "📧"},
    {":computer:", "💻"},
}) do
    vim.cmd("ab " .. ab[1] .. " " .. ab[2])
end

