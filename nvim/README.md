# Neovim 配置

**neovim 版本： 目前仅在0.7.0 版本测试通过， 其余版本请自行测试**

>建议：除了arch系linux，其余linux发行版在[此处](https://github.com/neovim/neovim/releases)下载可执行文件。 通过类似 `apt` 的方式安装往往都是旧版本。

使用方法：

1. clone本仓库，并在 `~/.config` 目录下建立nvim的软链接
  ```shell
  git clone https://github.com/ravenxrz/dotfiles.git ~/.config/dotfiles
  ln -s ~/.config/dotfiles/nvim ~/.config
  ```

2.执行 `nvim +PackerSync` 命令， 根据网络条件的不同，可能需要多次执行本命令，直到所有插件下载完成

3.通过`LspInstallInfo`命令安装对应lsp svr, 接着选中对应语言的server，如cpp为clangd， 按i执行安装

4.通过`DIInstall xxx`命令安装对应语言的 `debugger`, 除此外，需要在 `~/.dotfiles/nvim/lua/user/dap/`目录下新建对应语言的配置文件（已配置好c/cpp,go,python), 同时更新 `dap-config.lua` 文件下的 `config_debuggers()` 函数。

# 常用快捷键说明

> 注意：随着个人使用习惯的改变，快捷键可能会有所更改。 
>
> 快捷键定义位置说明：
>
> 1. 常用快捷键在 keymaps.lua 文件下定义
> 2. 和插件特定的快捷键一部分放在keymaps.lua文件，大部分放在该插件配置文件处。
>
> 可通过 `<space>`+h+k 快捷键调出快捷键查询窗口

个人 `leader` 键位设置为分号`;`
## 1. 文件目录 

| 快捷键         | 功能                         |
| -------------- | ---------------------------- |
|      e         | 开关目录树                   |
| `<leader>` + f | 定位当前文件在目录树所处位置 |
| o              | 打开文件/打开文件目录        |
| h              | 折叠一个层级目录             |
| d              | 删除文件                     |
| a              | 新建文件/新建文件夹          |
| r              | 重命名文件                   |
| x              | 剪切文件                     |
| p              | 粘贴                         |
| gy             | 拷贝文件绝对路径             |
| Y              | 拷贝文件相对路径             |
| y              | 拷贝文件名                   |

更多快捷键见 nvim-tree.lua 顶部注释

## 2. 常规动作

| 快捷键             | 功能                                                         |
| ------------------ | ------------------------------------------------------------ |
| `<space>` + o      | 打开大纲                                                     |
| `<space>` + f      | 搜索文件                                                     |
| `<space>` + F      | 搜索字符(依赖rg，可传入rg的各类参数，实现忽略大小写、正则表达式搜索等) |
| `<space>` + p      | 切换项目                                                     |
| `<space>` + r      | 最近文件                                                     |
| E                  | 打开左边标签页                                               |
| R                  | 打开右边标签页                                               |
| `<ctrl>` + h/j/k/l | 进入左边/下边/上边/右边窗口                                  |
| `<ctrl> + t`       | 打开终端                                                     |
| `<leader>` + b     | buffer 功能                                                   |
| `<leader>` + b + e | 关闭buffer                                                   |

## 3. 代码导航

| 快捷键          | 功能                                                         |
| --------------- | ------------------------------------------------------------ |
| `<leader>` + lH | 在声明/定义间来回跳转 (c和cpp项目，需要导出compile_commands.json文件) |
|     gr          | 查看代码引用                                                 |
|     ic          | 函数调用链                                                   |
| `]]`            | 跳转到下一个函数头                                           |
| `][`            | 跳转到下一个函数尾                                           |
| `[[`            | 跳转到上一个函数头                                           |
| `[]`            | 跳转到上一个函数尾                                           |
| gh              | 查看函数签名+注释文档                                        |
| gl              | 查看代码诊断                                                 |
| `<leader>` + lr | 重命名符号                                                   |
| `<leader>` + ls   | 搜索当前窗口下的符号 (类似vscode的 `@`)                      |
| `<leader>` + lS   | 搜索项目下的符号 (类似vscode `#`)                            |

## 4. 代码诊断

| 快捷键          | 功能                                |
| --------------- | ----------------------------------- |
| `<leader>` + lj | 下一个错误                          |
| `<leader>`+ lk  | 上一个错误                          |
| `<space>` + lw  | 错误窗口 （类似vscode problem pane) |

## 5. Git操作

| 快捷键          | 功能         |
| --------------- | ------------ |
|      ; + hj     | 下一个hunk   |
|      ; + hk     | 上一个hunk   |
|      ; + hs     | stage hunk   |
|      ; + hu     | unstage hunk |
|      ; + hr     | reset hunk   |
|      ; + hp     | preview hunk |
|      ; + hb     | blame file   |
| `<leader>` + gd  | diff file    |
| `<leader>` + gf  | file history |
| `<leader>` + gg  | 打开lazygit  |

## 6. Debug

| 快捷键          | 功能                                                         |
| --------------- | ------------------------------------------------------------ |
|     ; + db       | 开关断点                                                     |
|     ; + dc       | 条件断点                                                     |
| `<F5>/<F10>`    | 开始调试/continue                                            |
| `<F4>`          | 结束调试会话                                                 |
| `<F6>`          | stepover                                                     |
| `<F7>`          | stepinto                                                     |
| `<F8>`          | stepout                                                      |
| `<shift>` + k   | 变量悬浮窗（查看cursor下变量的值, 按两次`<shift>`+k使cursor聚焦到悬浮窗) |

## 7. hlslens 匹配

| 快捷键          | 功能                                                         |
| --------------- | ------------------------------------------------------------ |
|  */#/g*/g#      | 匹配光标所在的单词                                             |
|      n          | 向下查找                                                     |
|      N          | 向上查找                                                     |


## 7. 其他

- cmake： `<space>` + c后，查看which key的提示
- ultest: 单元测试插件， `<space>` + t
- TodoList:  无快捷键，执行 `:TodoTrouble`查看
- LocalHistory： 无快捷键， 执行 `:LocalHistoryToggle`查看
- Lsp svr： `<space>`+li（小l和小i), 查看当前lsp状态， `<space>` + lI(小L和大I)安装lsp svr

# 额外说明

此仓库bin目录下包含如下可执行文件:
- fd          -- telescope依赖
- glow        -- markdown预览依赖
- lazygit     -- git操作
- rg          -- telescope 依赖


# FAQ

**1.插件下载不下来？**

网络问题，插件都在github上，考虑加代理。

**2.bin目录下的可执行文件如何使用？**

bin目录下的文件是一些依赖可执行文件，如果通过 `install` 命令安装了所有配置，该目录默认会加载至系统PATH变量中，否则需要个人手动将该目录添加至PATH中，另外，这些文件仅在ubuntu20.04中测试使用通过，其余系统不保证。 所以可考虑手动下载依赖, 如 `apt install xxx`, `yum install xx` `pacman -S xxx`等等。

**3.终端颜色有问题?**

> mac建议使用iterm2, 或者kittiy， 不建议使用默认终端。

确认终端支持真彩色, 另外将 $TERM 环境变量设为 `xterm-256color`. 

**4.出现xxx not found**

大概率是因为没有下载完插件。 可以使用 `PackerStatus` 查看下当前有哪些插件。

**5.图标乱码问题**

没有安装nerd font, 请自行安装nerd font，并设置终端字体为对应的nerd font。

**6.PackerSync命令找不到？**

packer插件自动下载失败，网络问题。遇到此问题，可手动清除 `~/.local/share/nvim/site/pack/packer/start/packer.nvim/` 目录，然后重新开启nvim。不过首先要解决的是你的网络问题。

**7. 如何在右上角显示实时cpu和mem？**

这是tmux的配置，和nvim无关，有兴趣可自行查看我的tmux配置。

> 提示：要安装 `ravenxrz/tmux-plugin-sysstat` tmux插件，另外需要手动配置主题。如：
>
> `set -g status-right "#[fg=#1f2428,bg=#1f2428,nobold,nounderscore,noitalics]#[fg=#1f2428,bg=#1f2428] #{prefix_highlight} #[fg=#e1e4e8,bg=#1f2428,nobold,nounderscore,noitalics]#[fg=#586069,bg=#e1e4e8] %Y-%m-%d  %I:%M %p #[fg=#2188ff,bg=#e1e4e8,nobold,nounderscore,noitalics]#[fg=#1f2428,bg=#2188ff,bold] #{sysstat_cpu}#[fg=#1f2428,bg=#2188ff,bold] #{sysstat_mem}#[fg=#2188ff,bg=#2188ff,bold] "`

**8. c/cpp项目如何导出 compile_commands.json 文件？**

- makefile管理的项目： 使用 bear 工具（开源工具，自行下载），然后在项目工程下执行 `bear -- make` 
- cmake管理的项目： 使用快捷键 `<space> + cg`

## vim 与 tmux 
## vim 命令速记

. 	: 重复上次修改
x 	: 删除光标下的字符
a 	: 命令在当前光标之后添加内容
A 	: 命令则在当前行的结尾添加内容
s 	: 先删除光标下的字符，然后进入插入模式
; 	: 重复执行前面的操作, 例如 `f{char}`, `;` 则重复执行 `f{char}`
, 	: 反方向执行 `;` 动作
cw 	: 命令会删除从光标位置到单词结尾间的字符，并进入插入模式

	 例子: 删除某段文字所有 content 替换为 copy
	 	知识: Vim 会把我们离开插入模式之前的全部按键操作都记录下来

	 	1. 命令模式输入 /content
	 	2. 按 * 或 n 进行查找
	 	3. 按键 cw 删除 content 并进入 插入模式
	 	4. 输入 copy, 并按 <Esc>
	 	   此时 vim 会把 `cwcopy<Esc>` 作为一个修改
	 	5. 按 `n` 跳到下一个单词, 按 `.` 执行上次修改, 也就是 `cwcopy<Esc>`
### 替换
:[addr]s/源字符串/目的字符串/[option]
  [addr] 表示检索范围，省略时表示当前行。
    “1,20” ：表示从第1行到20行；
    “%” ：表示整个文件，同“1,$”；
    “. ,$” ：从当前行到文件尾；
  
  s : 表示替换操作
  
  [option] : 表示操作类型
    g 表示全局替换; 
    c 表示进行确认
    p 表示替代结果逐行显示（Ctrl + L恢复屏幕）;
    省略option时仅对每行第一个匹配串进行替换;
    如果在源字符串和目的字符串中出现特殊字符，需要用”\”转义 如 \t

# tmux 操作 默认操作
1. 启动：键入tmux命令，就进入了 Tmux 窗口
2. 退出：按下Ctrl+d或者显式输入exit命令
3. 唤起前缀键：先按下Ctrl+b，快捷键才会生效

## session 操作
1. 新建会话tmux new -s my_session。
2. 在 Tmux 窗口运行所需的程序。
3. 按下快捷键Ctrl+b d将会话分离。
4. 下次使用时，重新连接到会话 tmux attach-session -t my_session

## 窗口操作
1. Ctrl+b c：创建一个新窗口，状态栏会显示多个窗口的信息
3. Ctrl+b p：切换到上一个窗口（按照状态栏上的顺序）。
4. Ctrl+b n：切换到下一个窗口。
5. Ctrl+b <number>：切换到指定编号的窗口，其中的<number>是状态栏上的窗口编号。
6. Ctrl+b w：从列表中选择窗口。
7. Ctrl+b ,：窗口重命名


Ctrl+b %：划分左右两个窗格。
Ctrl+b "：划分上下两个窗格。
Ctrl+b <arrow key>：光标切换到其他窗格。<arrow key>是指向要切换到的窗格的方向键，比如切换到下方窗格，就按方向键↓。
Ctrl+b ;：光标切换到上一个窗格。
Ctrl+b o：光标切换到下一个窗格。
Ctrl+b {：当前窗格与上一个窗格交换位置。
Ctrl+b }：当前窗格与下一个窗格交换位置。
Ctrl+b Ctrl+o：所有窗格向前移动一个位置，第一个窗格变成最后一个窗格。
Ctrl+b Alt+o：所有窗格向后移动一个位置，最后一个窗格变成第一个窗格。
Ctrl+b x：关闭当前窗格。
Ctrl+b !：将当前窗格拆分为一个独立窗口。
Ctrl+b z：当前窗格全屏显示，再使用一次会变回原来大小。
Ctrl+b Shift+h/j/k/l 调整窗口大小。
Ctrl+b q：显示窗格编号


## tmux 设置操作, 大部分行为和默认一样
1. ctrl + b  ctrl + r 进入快捷设置，进入默认设置 
2. ctrl + b 映射成 ctrl + a
3. 关闭 pane ctrl + a X(大写)
4. 上下左右 pane 切换 ctrl + a h/j/k/l
5. ctrl + a |(垂直换分) / - (水平划分)






