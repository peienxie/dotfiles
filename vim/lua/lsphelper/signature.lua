local M = {}

-- automatically display signature helper windows
-- ref: https://github.com/glepnir/lspsaga.nvim/issues/145
function M.check_trigger_char(line_to_cursor, trigger_characters)
    if trigger_characters == nil then
        return false
    end
    for _, ch in ipairs(trigger_characters) do
        local current_char = string.sub(line_to_cursor, #line_to_cursor - #ch + 1, #line_to_cursor)
        if current_char == ch then
            return true
        end
        if current_char == " " and #line_to_cursor > #ch + 1 then
            local pre_char = string.sub(line_to_cursor, #line_to_cursor - #ch, #line_to_cursor - 1)
            if pre_char == ch then
                return true
            end
        end
    end
    return false
end

function M.show_signature_help()
    local clients = vim.lsp.buf_get_clients(0)
    if clients == nil or clients == {} then
        return
    end

    for _, client in pairs(clients) do
        if (client.server_capabilities.signatureHelpProvider) then
            local triggers = client.server_capabilities.signatureHelpProvider.triggerCharacters

            local pos = vim.api.nvim_win_get_cursor(0)
            local line = vim.api.nvim_get_current_line()
            local line_to_cursor = line:sub(1, pos[2])

            if M.check_trigger_char(line_to_cursor, triggers) then
                vim.lsp.buf.signature_help()
                break
            end
        end
    end
end

return M
