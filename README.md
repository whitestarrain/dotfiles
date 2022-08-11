# 前言：

- 尽可能只在init.vim中引入文件加载
- 保证迁移方便，在配置文件下写`source path/to/init.vim`即可

# 待做项

- **配置优化(重要)**
  - [ ] 暂不考虑纯lua配置。
  - [ ] 优化为符合vim配置规范的配置目录
    - `if !exists('g:loaded_xxxxxx') | finish | endif`
    - `pcall`
  - [ ] **init.vim 主题配置简化**
- [ ] 键位整理(重要)
- [x] coc换为lsp
- [x] LoadLua 函数 ,修改`package.path`
- [x] 配置结构优化
- [ ] README补充
- [x] airline换掉
- [x] react 开发环境搭建
- [x] 自动补全颜色
- [ ] 插件
  - vim-visual-multi
- [ ] init整理，替换`g:load_program`，各个语言插件单独配置
  > 主要是java jdtls
- [ ] bash自动化记录和设置插件版本
  - `vim-plug`的`PlugSnapshot`命令使用，但有较大局限性，只能在该插件中使用
- [ ] 拿c写一个启动程序？
- [ ] 把插件配置写到`after/plugin`，写一些`pcall`或者全局变量 什么的来判断是否加载？
- [ ] mklink 一些配置文件到dotfiles文件夹
  - 整理配置脚本
- lua配置中，require替换为pcall

# 备忘记录

- icon支持
  - 针对vimscript插件:`ryanoasis/vim-devicons`
  - 针对lua插件:`kyazdani42/nvim-web-devicons`

- treesitter的更新
  - 最好手动del后再clone
  - 否则偶尔可能出bug。
  - 吃过那个的苦

- indent
  - 大多数语言插件会提供indent支持。
  - 这里默认关闭了treesitter的indent。需要可以到[这里](./nvim/plug_configs/treesitter.vim)开启

- css classname auto complate
  - tailwindcss lsp
    - 使用tailwind开发时可以用
    - 同样可以用在react中
    - 但是需要taildwindcss依赖
    - [使用示例](https://www.youtube.com/watch?v=GznmPACXBlY&t=6227s)
  - [cssmodule_ls](https://github.com/antonk52/cssmodules-language-server): 
    - 比较通用
    - 但是windows上不太好用

- `_pre`文件夹下保存一些不太常用的功能
  - 可能会在未来重新调整一下配置

- 配置修改后使用nvimPower看一下有没有报错

# 键位整理

> TODO: 键位整理

# 图片展示

- Session

   点击进入session后会还原之前编辑的文件，编辑位置，界面布局等等。

  ![dotfile-9](./image/dotfile-9.png)


- lsp

  ![dotfile-1](./image/dotfile-1.png)

  ![dotfile-7](./image/dotfile-7.png)

  ![dotfile-6](./image/dotfile-6.png)

- 自动补全

  ![dotfile-2](./image/dotfile-2.png)

  ![dotfile-3](./image/dotfile-3.png)

  ![dotfile-5](./image/dotfile-5.png)

- 多环境支持

  ![dotfile-4](./image/dotfile-4.png)

- session支持(类似vscode的工作空间)

- todo list

  ![dotfile-8](./image/dotfile-8.png)

- ...(有时间再补充)

# 参考配置

- [ ] [voldikss/dotfiles](https://github.com/voldikss/dotfiles/blob/dev/nvim/init.vim)
- [ ] [craftzdog/dotfiles-public](https://github.com/craftzdog/dotfiles-public)
- [ ] [bluz71/dotfiles](https://github.com/bluz71/dotfiles/blob/master/vim/lua/plugin/lsp-config.lua)
