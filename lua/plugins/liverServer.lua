return {
    {
        'barrett-ruth/live-server.nvim',
        build = 'npm install global live-server',
        cmd = { 'LiveServerStart', 'LiveServerStop' },
        init = function()
            vim.g.live_server = {}
        end,
    },
}
