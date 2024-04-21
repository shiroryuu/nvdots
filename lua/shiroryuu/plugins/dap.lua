return {
    -- TODO: configure DAP
    "mfussenegger/nvim-dap",
    lazy = true,
    dependencies = {
        {
            "jay-babu/mason-nvim-dap.nvim",
            dependencies = { "nvim-dap", "williamboman/mason.nvim" },
            cmd = { "DapInstall", "DapUninstall" },
            init = function() end,
            opts = { handlers = {} },
        },
        -- Fancy ui for the debugger
        {
            "rcarriga/nvim-dap-ui",
            dependencies = { "nvim-neotest/nvim-nio" },
            keys = {
                { "<Leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
                { "<Leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
            },
            opts = {},
            config = function(_, opts)
                local dap = require("dap")
                local dapui = require("dapui")
                dapui.setup(opts)
                dap.listeners.after.event_initialized["dapui_config"] = function()
                    dapui.open({})
                end
                dap.listeners.before.event_terminated["dapui_config"] = function()
                    dapui.close({})
                end
                dap.listeners.before.event_exited["dapui_config"] = function()
                    dapui.close({})
                end
            end
        },
    },
}
