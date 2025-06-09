vim.lsp.enable({
  "bashls",
  "gopls",
  "intelephense",
  "lua_ls",
  "ts_ls",
})

vim.diagnostic.config({
  virtual_lines = false,
  virtual_text = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    border = "rounded",
    source = true,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = "",
      [vim.diagnostic.severity.HINT] = " ",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)

    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
    map("gr", function()
      require("telescope.builtin").lsp_references({
        show_line = false
      })
    end, "[G]oto [R]eferences")
    map("gt", vim.lsp.buf.type_definition, "[G]oto [T]ype definition")
    map("<Leader>rn", vim.lsp.buf.rename, "[R]e[N]ame")
    map("<Leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("<Leader>fsd", require("telescope.builtin").lsp_document_symbols, "[F]ind [S]ymbols in [D]ocument")
    map("<Leader>fsw", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[F]ind [S]ymbols in [W]orkspact")

    -- Diagnostics
    map("<Leader>lf", vim.lsp.buf.format, "[L]SP [F]ormat")
    map("<Leader>q", vim.diagnostic.setloclist, "Diagnostics to locallist")

  end
})

-- Extras

local function restart_lsp(bufnr)
    bufnr = bufnr or vim.api.nvim_get_current_buf()
    local clients
    if vim.lsp.get_clients then
        clients = vim.lsp.get_clients({ bufnr = bufnr })
    else
        ---@diagnostic disable-next-line: deprecated
        clients = vim.lsp.get_active_clients({ bufnr = bufnr })
    end

    for _, client in ipairs(clients) do
        vim.lsp.stop_client(client.id)
    end

    vim.defer_fn(function()
        vim.cmd('edit')
    end, 100)
end

vim.api.nvim_create_user_command('LspRestart', function()
    restart_lsp()
end, {})

local function lsp_status()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr }) or
        vim.lsp.get_active_clients({ bufnr = bufnr })

    if #clients == 0 then
        print("󰅚 No LSP clients attached")
        return
    end

    print("󰒋 LSP Status for buffer " .. bufnr .. ":")
    print("─────────────────────────────────")

    for i, client in ipairs(clients) do
        print(string.format("󰌘 Client %d: %s (ID: %d)", i, client.name, client.id))
        print("  Root: " .. (client.config.root_dir or "N/A"))
        print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

        -- Check capabilities
        local caps = client.server_capabilities
        local features = {}
        if caps.completionProvider then table.insert(features, "completion") end
        if caps.hoverProvider then table.insert(features, "hover") end
        if caps.definitionProvider then table.insert(features, "definition") end
        if caps.referencesProvider then table.insert(features, "references") end
        if caps.renameProvider then table.insert(features, "rename") end
        if caps.codeActionProvider then table.insert(features, "code_action") end
        if caps.documentFormattingProvider then table.insert(features, "formatting") end

        print("  Features: " .. table.concat(features, ", "))
        print("")
    end
end

vim.api.nvim_create_user_command('LspStatus', lsp_status, { desc = "Show detailed LSP status" })

local function check_lsp_capabilities()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr }) or
        vim.lsp.get_active_clients({ bufnr = bufnr })

    if #clients == 0 then
        print("No LSP clients attached")
        return
    end

    for _, client in ipairs(clients) do
        print("Capabilities for " .. client.name .. ":")
        local caps = client.server_capabilities

        local capability_list = {
            { "Completion",                caps.completionProvider },
            { "Hover",                     caps.hoverProvider },
            { "Signature Help",            caps.signatureHelpProvider },
            { "Go to Definition",          caps.definitionProvider },
            { "Go to Declaration",         caps.declarationProvider },
            { "Go to Implementation",      caps.implementationProvider },
            { "Go to Type Definition",     caps.typeDefinitionProvider },
            { "Find References",           caps.referencesProvider },
            { "Document Highlight",        caps.documentHighlightProvider },
            { "Document Symbol",           caps.documentSymbolProvider },
            { "Workspace Symbol",          caps.workspaceSymbolProvider },
            { "Code Action",               caps.codeActionProvider },
            { "Code Lens",                 caps.codeLensProvider },
            { "Document Formatting",       caps.documentFormattingProvider },
            { "Document Range Formatting", caps.documentRangeFormattingProvider },
            { "Rename",                    caps.renameProvider },
            { "Folding Range",             caps.foldingRangeProvider },
            { "Selection Range",           caps.selectionRangeProvider },
        }

        for _, cap in ipairs(capability_list) do
            local status = cap[2] and "✓" or "✗"
            print(string.format("  %s %s", status, cap[1]))
        end
        print("")
    end
end

vim.api.nvim_create_user_command('LspCapabilities', check_lsp_capabilities, { desc = "Show LSP capabilities" })

local function lsp_diagnostics_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local diagnostics = vim.diagnostic.get(bufnr)

    local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

    for _, diagnostic in ipairs(diagnostics) do
        local severity = vim.diagnostic.severity[diagnostic.severity]
        counts[severity] = counts[severity] + 1
    end

    print("󰒡 Diagnostics for current buffer:")
    print("  Errors: " .. counts.ERROR)
    print("  Warnings: " .. counts.WARN)
    print("  Info: " .. counts.INFO)
    print("  Hints: " .. counts.HINT)
    print("  Total: " .. #diagnostics)
end

vim.api.nvim_create_user_command('LspDiagnostics', lsp_diagnostics_info, { desc = "Show LSP diagnostics count" })


local function lsp_info()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr }) or
        vim.lsp.get_active_clients({ bufnr = bufnr })

    print("═══════════════════════════════════")
    print("           LSP INFORMATION          ")
    print("═══════════════════════════════════")
    print("")

    -- Basic info
    print("󰈙 Language client log: " .. vim.lsp.get_log_path())
    print("󰈔 Detected filetype: " .. vim.bo.filetype)
    print("󰈮 Buffer: " .. bufnr)
    print("󰈔 Root directory: " .. (vim.fn.getcwd() or "N/A"))
    print("")

    if #clients == 0 then
        print("󰅚 No LSP clients attached to buffer " .. bufnr)
        print("")
        print("Possible reasons:")
        print("  • No language server installed for " .. vim.bo.filetype)
        print("  • Language server not configured")
        print("  • Not in a project root directory")
        print("  • File type not recognized")
        return
    end

    print("󰒋 LSP clients attached to buffer " .. bufnr .. ":")
    print("─────────────────────────────────")

    for i, client in ipairs(clients) do
        print(string.format("󰌘 Client %d: %s", i, client.name))
        print("  ID: " .. client.id)
        print("  Root dir: " .. (client.config.root_dir or "Not set"))
        print("  Command: " .. table.concat(client.config.cmd or {}, " "))
        print("  Filetypes: " .. table.concat(client.config.filetypes or {}, ", "))

        -- Server status
        if client.is_stopped() then
            print("  Status: 󰅚 Stopped")
        else
            print("  Status: 󰄬 Running")
        end

        -- Workspace folders
        if client.workspace_folders and #client.workspace_folders > 0 then
            print("  Workspace folders:")
            for _, folder in ipairs(client.workspace_folders) do
                print("    • " .. folder.name)
            end
        end

        -- Attached buffers count
        local attached_buffers = {}
        for buf, _ in pairs(client.attached_buffers or {}) do
            table.insert(attached_buffers, buf)
        end
        print("  Attached buffers: " .. #attached_buffers)

        -- Key capabilities
        local caps = client.server_capabilities
        local key_features = {}
        if caps.completionProvider then table.insert(key_features, "completion") end
        if caps.hoverProvider then table.insert(key_features, "hover") end
        if caps.definitionProvider then table.insert(key_features, "definition") end
        if caps.documentFormattingProvider then table.insert(key_features, "formatting") end
        if caps.codeActionProvider then table.insert(key_features, "code_action") end

        if #key_features > 0 then
            print("  Key features: " .. table.concat(key_features, ", "))
        end

        print("")
    end

    -- Diagnostics summary
    local diagnostics = vim.diagnostic.get(bufnr)
    if #diagnostics > 0 then
        print("󰒡 Diagnostics Summary:")
        local counts = { ERROR = 0, WARN = 0, INFO = 0, HINT = 0 }

        for _, diagnostic in ipairs(diagnostics) do
            local severity = vim.diagnostic.severity[diagnostic.severity]
            counts[severity] = counts[severity] + 1
        end

        print("  󰅚 Errors: " .. counts.ERROR)
        print("  󰀪 Warnings: " .. counts.WARN)
        print("  󰋽 Info: " .. counts.INFO)
        print("  󰌶 Hints: " .. counts.HINT)
        print("  Total: " .. #diagnostics)
    else
        print("󰄬 No diagnostics")
    end

    print("")
    print("Use :LspLog to view detailed logs")
    print("Use :LspCapabilities for full capability list")
end

-- Create command
vim.api.nvim_create_user_command('LspInfo', lsp_info, { desc = "Show comprehensive LSP information" })

local function lsp_status_short()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients and vim.lsp.get_clients({ bufnr = bufnr }) or
        vim.lsp.get_active_clients({ bufnr = bufnr })

    if #clients == 0 then
        return "" -- Return empty string when no LSP
    end

    local names = {}
    for _, client in ipairs(clients) do
        table.insert(names, client.name)
    end

    return "󰒋 " .. table.concat(names, ",")
end
