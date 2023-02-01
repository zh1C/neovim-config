# 安装

- **Neovim安装**

Neovim可以通过包管理的方式进行安装，Mac系统通过Homebrew安装。开发版本的安装方式为：

`brew install --HEAD neovim`

更新方式为：

`brew upgrade neovim --fetch-HEAD`

# 配置文件整体结构

**init.lua** 是整个配置的入口文件，负责引用所有其他的模块，基本上想要打开或关闭某个插件只要在这里修改一行代码即可。

- **basic.lua：** 基础配置，是对默认配置的一个重置。
- **colorscheme.lua：** 我们安装的主题皮肤配置，在这里切换主题。
- **keybindings.lua：** 快捷键的设置，所有插件的快捷键也都会放在这里。
- **plugins.lua：** 插件安装管理，插件安装或卸载全在这里设置。
- **lsp文件夹** ：是对 Neovim 内置 LSP 功能的配置，包括常见编程语言与语法提示等。
- **cmp文件夹**：对Neovim的代码补全功能进行配置。
- **format文件夹**：对Neovim的代码格式化功能进行配置，通过null-ls插件实现formatting。
- **dap文件夹**：对neovim的代码调试功能进行配置。
- **plugin-config文件夹**：单独对各个插件的配置。

------

待补充。。。
