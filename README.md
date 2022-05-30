# 前言：

- 尽可能只在init.vim中引入文件加载
- 保证迁移方便，在配置文件下写`source path/to/init.vim`即可

# 待做项

- [ ] 键位整理(重要)
- [x] coc换为lsp
- [ ] ~lua替换vim配置~
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
- [ ] 拿c写一个启动程序？

# 记录

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


# 参考配置

- [ ] [voldikss/dotfiles](https://github.com/voldikss/dotfiles/blob/dev/nvim/init.vim)
- [ ] [craftzdog/dotfiles-public](https://github.com/craftzdog/dotfiles-public)
- [ ] [bluz71/dotfiles](https://github.com/bluz71/dotfiles/blob/master/vim/lua/plugin/lsp-config.lua)
