return {
    "David-Kunz/gen.nvim",
    opts = {
        model = 'deepseek-coder-v2:16b-lite-instruct-q8_0',
        display_mode = 'vsplit'
    }
}
--local localGen = vim.fn.expand('$HOME/code/j/gen.nvim')
--local remoteGen = 'jaredhabeck/gen.nvim'
--local f = io.open(localGen,'r')
--if f~=nil then
--    print('running local gen.nvim')
--    GenConfig = { dir = localGen }
--else
--    print('running remote gen.nvim')
--    GenConfig = { remoteGen }
--end
--
--GenConfig.model = 'deepseek-coder-v2:16b-lite-instruct-q8_0'
--GenConfig.quit_map = "q" -- set keymap for close the response window
--GenConfig.retry_map = "<c-r>" -- set keymap to re-send the current prompt
--GenConfig.accept_map = "<c-cr>" -- set keymap to replace the previous selection with the last result
--GenConfig.host = "localhost" -- The host running the Ollama service.
--GenConfig.port = "11434" -- The port on which the Ollama service is listening.
--GenConfig.display_mode = "vsplit" -- The display mode. Can be "float" or "split" or "horizontal-split".
--GenConfig.show_prompt = false -- Shows the prompt submitted to Ollama.
--GenConfig.show_model = false -- Displays which model you are using at the beginning of your chat session.
--GenConfig.no_auto_close = false -- Never closes the window automatically.
--GenConfig.hidden = false -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
--GenConfig.init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end
---- The executed command must return a JSON object with { response, context }
---- (context property is optional).
--GenConfig.debug = true
--
--return GenConfig
