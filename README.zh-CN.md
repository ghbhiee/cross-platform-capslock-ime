# 跨平台 Caps Lock 中英文切换

[English](README.md) | [简体中文](README.zh-CN.md)

这是一套小巧的 AutoHotkey v2 配置，目的是让 Windows 和 macOS 拥有一致的
中英文输入切换体验。

在 Windows 上，短按一次 <kbd>Caps Lock</kbd>，即可在美式英文键盘和微软拼音
之间切换；在 macOS 上，启用系统自带的 Caps Lock 输入源切换功能后，可以获得
相同的操作习惯。

Windows 脚本还会把鼠标侧键原本的“后退/前进”替换成快速上下滚动，降低误触侧键、
离开当前网页并丢失尚未提交的表单内容的风险。

## 功能一览

| 操作 | 结果 |
| --- | --- |
| 松开 <kbd>Caps Lock</kbd> | 发送 <kbd>左 Alt</kbd> + <kbd>左 Shift</kbd> |
| 按鼠标侧键 1 | 向下滚动 6 格 |
| 按鼠标侧键 2 | 向上滚动 6 格 |
| 在微软拼音下按 <kbd>Ctrl</kbd> + <kbd>.</kbd> | 持久切换中文/英文标点 |
| 普通按下 <kbd>Caps Lock</kbd> | 阻止系统原有的大写锁定行为 |

这些映射全局生效，会应用到所有程序。

## 为什么要使用这套配置

### 统一 Windows 和 macOS 的操作习惯

macOS 可以直接使用 Caps Lock，在 ABC 等拉丁输入源和简体拼音等非拉丁输入源
之间切换。本项目让 Windows 也使用同一个按键完成相同任务，从而在两套系统之间
切换时保持一致的肌肉记忆。

### 防止鼠标侧键导致表单内容丢失

许多鼠标默认把两个侧键映射为浏览器的“后退”和“前进”。如果在填写表单、编辑后台
页面、结账流程或者不支持自动保存的网站中误触“后退”，尚未提交的内容可能全部丢失。

脚本会拦截原始的 `XButton1` 和 `XButton2` 事件，浏览器因而不会再收到前进或
后退指令。同时，两个侧键会被重新利用为快速上下滚动，而不是被简单禁用。

## 理解 Windows 的两层输入状态

Windows 中有两种看起来都像“切换中英文”的操作，但它们并不是同一件事。

### 第一层：键盘布局或输入法

本项目建议只保留两个输入配置：

- 英语（美国）— 美式键盘
- 中文（简体，中国）— 微软拼音

Windows 可以让每个应用窗口分别保持这一层的输入配置。以下操作切换的都是这一层：

- <kbd>Win</kbd> + <kbd>Space</kbd>
- <kbd>左 Alt</kbd> + <kbd>Shift</kbd>
- 本项目映射后的 <kbd>Caps Lock</kbd>

本项目的完整输入逻辑是：

```text
Caps Lock
    ↓ AHK 发送左 Alt + 左 Shift
真正的输入法切换：美式英文键盘 ↔ 微软拼音
                                      ↓ Ctrl + Space
                            微软拼音中文模式 ↔ 内部英文模式
```

### 第二层：微软拼音内部的中英文模式

微软拼音自身还包含两个状态：

- 中文转换模式：输入拼音后产生汉字候选项
- 英文直输模式：不进行拼音转换，直接输出英文字母

微软拼音当前默认可用 <kbd>Shift</kbd> 切换这两个状态。Windows 还可能启用了一个
旧式的 IME/Non-IME 快捷键，即 <kbd>Ctrl</kbd> + <kbd>Space</kbd>。

本项目特意使用 <kbd>Ctrl</kbd> + <kbd>Space</kbd>，并关闭微软拼音默认的
<kbd>Shift</kbd> 模式切换。原因是 Caps Lock 已经被占用，输入英文大写字母时需要
频繁按住 Shift；如果保留“单独按 Shift 切换中英文”，正常输入大写字母时更容易意外
改变微软拼音的模式。

需要注意：微软拼音内部的英文模式，不等于切换到了真正的“英语（美国）— 美式键盘”。
Windows 不保证按应用可靠恢复这个临时模式，而且程序或文字输入控件也可能主动重置它。

如果你的目标是：

- Windows Terminal 默认使用英文
- Obsidian 或其他笔记软件默认使用中文

正确做法是让终端使用真正的美式英文键盘，让笔记软件使用微软拼音，而不是让两个程序
都停留在微软拼音，再依赖微软拼音内部的临时中英文状态。

## 系统要求

- Windows 10 或 Windows 11
- [AutoHotkey v2](https://www.autohotkey.com/download/)
- 建议只启用以下两个输入配置：
  - 英语（美国）— 美式键盘
  - 中文（简体，中国）— 微软拼音

脚本通过 `#Requires AutoHotkey v2.0` 明确要求 v2，不能使用 AutoHotkey v1
解释执行。

## 安装 AutoHotkey v2

1. 打开 AutoHotkey 官方[下载页面](https://www.autohotkey.com/download/)。
2. 下载当前版本的 AutoHotkey v2 安装程序。
3. 运行安装程序。
4. 如果没有管理员权限，可以选择仅为当前用户安装；否则使用推荐的默认设置即可。
5. 安装完成后，确认 `.ahk` 文件默认使用 AutoHotkey v2 打开。

完整语法和使用说明参见
[AutoHotkey v2 官方文档](https://www.autohotkey.com/docs/v2/)。

## 配置 Windows 输入法

### 添加美式英文键盘和微软拼音

1. 打开“设置”。
2. 进入“时间和语言” > “语言和区域”。
3. 确认“英语（美国）”中安装了“美式键盘”。
4. 确认“中文（简体，中国）”中安装了“微软拼音”。
5. 尽量删除不使用的其他键盘布局。

脚本发送的是 <kbd>左 Alt</kbd> + <kbd>Shift</kbd>。这个快捷键会在所有已安装的
输入配置之间循环。如果安装了三个或更多输入配置，Caps Lock 可能循环到第三种布局，
不再是简单而确定的二态切换。

### 让每个应用窗口保持不同的输入法

1. 打开“设置”。
2. 进入“时间和语言” > “输入”。
3. 打开“高级键盘设置”。
4. 启用“允许我为每个应用窗口使用不同的输入法”。

![Windows 高级键盘设置：允许每个应用窗口使用不同的输入法](docs/images/windows-per-app-input-method.png)

**图 1：** 启用“允许我为每个应用窗口使用不同的输入法”。截图中的“替代默认输入法”
设为“英语（美国）— 美式键盘”，因此新程序或没有独立状态的输入框会优先从英文键盘开始。

启用后，每个正在运行的应用窗口可以保持自己的输入配置。例如：

- 在 Windows Terminal 中切换到真正的 **ENG / 美式键盘**。
- 在笔记软件中切换到 **微软拼音 / 中文模式**。
- 在两个窗口之间切换，确认它们分别保持各自的输入法。

这个功能不是一个永久的“程序与输入法对应规则”。新建窗口、重新启动程序，或者程序
重新创建文字输入控件时，仍可能继承或重置输入状态。

### 确认输入语言快捷键

1. 打开“设置” > “时间和语言” > “输入”。
2. 打开“高级键盘设置”。
3. 点击“输入语言热键”。
4. 在“高级键设置”中，确认“在输入语言之间”使用
   <kbd>左 Alt</kbd> + <kbd>Shift</kbd>。

![Windows 输入语言热键：左 Alt 加 Shift](docs/images/windows-input-language-hotkeys.png)

**图 2：** “在输入语言之间”设置为 <kbd>左 Alt</kbd> + <kbd>Shift</kbd>。AHK
在松开 Caps Lock 时发送的正是这个组合键，所以这是 Caps Lock 实际对应的 Windows
设置。列表中的“中文（简体输入法）— 输入法/非输入法切换”是下一层状态，设置为
<kbd>Ctrl</kbd> + <kbd>Space</kbd>。

无论如何设置，<kbd>Win</kbd> + <kbd>Space</kbd> 都很适合用来查看当前有哪些输入
配置，或者手动选择指定的输入法。

### `Ctrl + Space` 在哪里设置

<kbd>Ctrl</kbd> + <kbd>Space</kbd> 是 Windows 旧式的 IME/Non-IME 切换快捷键，
用于切换微软拼音内部的中文转换和英文直输模式。

可以尝试从以下位置找到它：

1. 打开“设置” > “时间和语言” > “输入”。
2. 打开“高级键盘设置”。
3. 点击“输入语言热键”。
4. 切换到“高级键设置”。
5. 找到类似“中文（简体）IME - IME/Non-IME Toggle”的项目。
6. 点击“更改按键顺序”。

微软拼音自身的按键页面应配置为：

![微软拼音按键设置](docs/images/microsoft-pinyin-key-settings.png)

**图 3：**

- “中/英文模式切换”只启用 <kbd>Ctrl</kbd> + <kbd>Space</kbd>。
- 关闭单独的 <kbd>Shift</kbd> 和 <kbd>Ctrl</kbd> 模式切换。
- “全/半角切换”设为“无”，避免按 <kbd>Ctrl</kbd> + <kbd>Space</kbd> 时误碰
  <kbd>Shift</kbd> + <kbd>Space</kbd>，意外进入很少使用的全角模式。
- 保留“中/英文标点切换” <kbd>Ctrl</kbd> + <kbd>.</kbd>。
- 如果需要使用 <kbd>Ctrl</kbd> + <kbd>.</kbd> 动态切换，必须在微软拼音
  **“常规”**页面关闭“中文输入时使用英文标点”。

微软拼音按键页面的路径通常为：

1. “设置” > “时间和语言” > “语言和区域”。
2. 在“中文（简体，中国）”旁打开“语言选项”。
3. 在“微软拼音”旁打开“键盘选项”。
4. 进入“按键”。

在较新的 Windows 11 中，这个旧式项目有时不会完整显示，或者界面上的修改不能可靠
生效。它的底层配置通常位于：

```text
HKEY_CURRENT_USER\Control Panel\Input Method\Hot Keys\00000010
```

不建议仅为修改这个快捷键而手工编辑注册表，除非已经备份并理解相应二进制值。

## 安装本项目脚本

### 先临时测试

1. 下载或克隆本仓库。
2. 双击 `capslock-ime-safe-mouse.ahk`。
3. 确认系统托盘中出现 AutoHotkey 图标。
4. 测试 Caps Lock 和两个鼠标侧键。

如需停止测试，右键单击 AutoHotkey 托盘图标，然后选择“Exit”。

### 登录 Windows 时自动启动

最简单的方法：

1. 按 <kbd>Win</kbd> + <kbd>R</kbd>。
2. 输入 `shell:startup`。
3. 按 <kbd>Enter</kbd>。
4. 在打开的启动目录中，为 `capslock-ime-safe-mouse.ahk` 创建快捷方式。
5. 注销并重新登录，或者先手动运行一次该快捷方式。

### 可选：使用独立配置目录

如果不想把实际配置文件放进启动目录，可以使用加载器：

1. 创建以下目录：

   ```text
   C:\Users\YOUR_USERNAME\.config\autohotkey\
   ```

2. 把 `capslock-ime-safe-mouse.ahk` 复制到该目录。
3. 打开 `startup-loader.example.ahk`。
4. 把其中的 `YOUR_USERNAME` 替换为实际 Windows 用户名。
5. 将文件重命名为 `autohotkey-startup-loader.ahk`。
6. 把加载器复制到 `shell:startup` 打开的目录中。

加载器只包含 AutoHotkey 版本要求和一个 `#Include` 指令。Windows 登录时启动加载器，
加载器再从稳定的 `.config` 目录读取主配置。

## 脚本核心逻辑

完整、可直接运行的版本参见
[`capslock-ime-safe-mouse.ahk`](capslock-ime-safe-mouse.ahk)。

```ahk
#Requires AutoHotkey v2.0
#SingleInstance Force

InstallKeybdHook
SetCapsLockState "AlwaysOff"

*SC03A::Return
*SC03A Up::
{
    SendEvent "{LAlt down}{LShift down}"
    Sleep 30
    SendEvent "{LShift up}{LAlt up}"
}

XButton1::Send "{WheelDown 6}"
XButton2::Send "{WheelUp 6}"

#HotIf IsSimplifiedChineseLayoutActive()
^.::TogglePersistentPunctuation()
#HotIf
```

## 逐段解释

### `#Requires AutoHotkey v2.0`

告诉 AutoHotkey 启动器，本脚本必须由 v2 执行，同时避免脚本被 AutoHotkey v1 错误
解释。

### `#SingleInstance Force`

再次运行脚本时，自动替换已经运行的同一脚本实例，而不是提示重复运行。编辑和重新加载
配置时会更方便。

### `InstallKeybdHook`

安装键盘钩子，以便稳定捕获物理 Caps Lock 按键。

### `SetCapsLockState "AlwaysOff"`

强制保持系统原生大写锁定状态关闭。Caps Lock 因而可以被专门用于切换输入法。

### `SC03A`

`SC03A` 是 Caps Lock 常用的物理扫描码。

```ahk
*SC03A::Return
```

这行代码拦截 Caps Lock 的按下事件。前面的 `*` 是通配修饰符，表示即使同时按住
Ctrl、Alt、Shift 或 Win，也会匹配这个热键。

```ahk
*SC03A Up::
```

只在松开 Caps Lock 时执行后续操作，从而形成干净、完整的单击手势。

### 模拟左 Alt + 左 Shift

```ahk
SendEvent "{LAlt down}{LShift down}"
Sleep 30
SendEvent "{LShift up}{LAlt up}"
```

脚本按下两个修饰键，保持 30 毫秒，让 Windows 稳定识别组合键，然后依次松开。

### 重映射鼠标侧键

```ahk
XButton1::Send "{WheelDown 6}"
XButton2::Send "{WheelUp 6}"
```

原始侧键事件会被拦截，所以浏览器不会再执行后退或前进。每按一次侧键，脚本改为发送
六格滚轮事件。

不同鼠标可能以相反顺序定义两个物理侧键。如果滚动方向不符合习惯，可以交换
`WheelDown` 和 `WheelUp`。如果滚动速度过快或过慢，把 `6` 改成其他正整数即可。

### 持久化中英文标点

微软拼音原生的标点状态不能可靠地跨应用保存，因此脚本会在简体中文布局活动时接管
<kbd>Ctrl</kbd> + <kbd>.</kbd>：

```ahk
currentValue := RegRead(settingsKey, valueName, 0)
newValue := currentValue ? 0 : 1
RegWrite newValue, "REG_DWORD", settingsKey, valueName
```

它直接切换：

```text
HKCU\Software\Microsoft\InputMethod\Settings\CHS
UseEnglishPunctuationsInChineseInputMode
```

- `0`：中文标点。
- `1`：中文输入时固定使用英文标点。

写入后，脚本向当前窗口请求先切到美式英文布局，再切回简体中文布局，迫使微软拼音
立即重新读取设置。屏幕上会短暂显示“Punctuation: English”或
“Punctuation: Chinese”。

`#HotIf` 限制保证只有简体中文布局活动时才接管该快捷键。在美式英文键盘下，
<kbd>Ctrl</kbd> + <kbd>.</kbd> 仍会交给当前应用处理。

## 微软拼音的标点与全角/半角设置

微软拼音处于活动状态时，可以使用：

| 快捷键 | 功能 |
| --- | --- |
| <kbd>Ctrl</kbd> + <kbd>Space</kbd> | 在微软拼音的中文和内部英文模式之间切换 |
| <kbd>Ctrl</kbd> + <kbd>.</kbd> | 由 AHK 持久切换中文和英文标点 |
| <kbd>Shift</kbd> | 本项目关闭该模式切换，保留给英文大写输入 |
| <kbd>Shift</kbd> + <kbd>Space</kbd> | 本项目关闭该功能，防止误切到全角 |

如果希望在中文输入状态下使用 ASCII 标点，应当使用：

- 微软拼音中文转换模式
- 英文标点模式
- 半角字符模式

效果示例：

```text
中文输入, 但使用 ASCII 标点: ()[]{}:;,.!?
```

微软官方参考：
[Microsoft 简体中文输入法](https://support.microsoft.com/zh-CN/Windows/Hardware/Input-Devices/microsoft-simplified-chinese-ime)。

### 为什么 `Ctrl + .` 看起来没有作用

以下限制描述的是**微软拼音原生行为**。本项目当前版本已由 AHK 接管该快捷键，
直接切换持久化注册表设置，并刷新当前输入法，从而绕过这个限制。

首先检查微软拼音“常规”页面中的：

```text
中文输入时使用英文标点
```

如果这个选项已经开启，新版微软拼音会固定使用英文标点并忽略
<kbd>Ctrl</kbd> + <kbd>.</kbd>。即使“按键”页面仍显示“中/英文标点切换：
Ctrl + 句点”，快捷键也不会切换。这是新版微软拼音已知的行为。

如果需要动态切换：

1. 打开“设置” > “时间和语言” > “语言和区域”。
2. 打开“中文（简体，中国）”的“语言选项”。
3. 打开“微软拼音”的“键盘选项”。
4. 进入“常规”。
5. 关闭“中文输入时使用英文标点”。
6. 回到“按键”，保留“中/英文标点切换：
   <kbd>Ctrl</kbd> + <kbd>.</kbd>”。
7. 切换到其他输入法再切回微软拼音，或者关闭并重新打开当前输入框。

关闭固定英文标点选项后，<kbd>Ctrl</kbd> + <kbd>.</kbd> 不会弹出提示窗口，
只会改变**之后输入的标点**，而且仅在微软拼音的**中文模式**下生效。微软官方也
特别注明，该组合键只在中文模式中有效。

可以在 Windows 记事本中这样验证：

1. 用 Caps Lock 切换到“微软拼音”，确认任务栏或输入法工具栏显示中文模式。
2. 输入逗号和句号，中文标点模式应得到：

   ```text
   ，。
   ```

3. 按一次 <kbd>Ctrl</kbd> + <kbd>.</kbd>。
4. 再输入逗号和句号，英文标点模式应得到：

   ```text
   ,.
   ```

如果切换前后始终得到 `,.`，依次检查：

1. “中文输入时使用英文标点”是否仍然开启。
2. 微软拼音是否处于内部英文模式；按 <kbd>Ctrl</kbd> + <kbd>Space</kbd>
   回到中文模式后再试。

如果记事本中有效、但某个程序中无效，说明该程序拦截了快捷键。如果记事本中也无效：

1. 确认微软拼音“按键”页面仍选择了 <kbd>Ctrl</kbd> + <kbd>.</kbd>。
2. 将该选项切换到“无”，保存后再重新启用。
3. 切换到其他输入法再切回微软拼音，必要时注销并重新登录 Windows。

“全/半角切换”和“中/英文标点切换”是两项独立设置。关闭全/半角快捷键不会导致
<kbd>Ctrl</kbd> + <kbd>.</kbd> 失效。

新版微软拼音实际上要求在以下两种行为中选择：

- **始终使用英文标点：** 开启“中文输入时使用英文标点”，但
  <kbd>Ctrl</kbd> + <kbd>.</kbd> 无法动态切换。
- **允许动态切换：** 关闭该固定选项，再使用
  <kbd>Ctrl</kbd> + <kbd>.</kbd>。

微软社区中也有同样问题的记录：
[开启“中文输入时使用英文标点”后 Ctrl+句点失效](https://learn.microsoft.com/zh-cn/answers/questions/3842555/windows11-ctrl)。

本项目的 AHK 方案把这个固定选项本身当作二态开关，因此标点选择会保存到用户注册表，
并被之后打开的应用和输入框继续使用。

## 配置 macOS 获得一致体验

macOS 不需要安装 AutoHotkey。

### 使用 Caps Lock 切换输入源

1. 打开“系统设置” > “键盘”。
2. 在“文字输入”旁点击“编辑”。
3. 如果尚未添加，请加入“ABC”和“简体拼音”。
4. 启用“使用大写锁定键切换 ABC 和当前输入法”。

短按 Caps Lock 会在 ABC 和简体拼音之间切换。在受支持的 Apple 键盘和 macOS
版本中，长按 Caps Lock 可以激活正常的大写锁定。

Apple 官方参考：
[在 Mac 上切换到中文或粤语输入法](https://support.apple.com/zh-cn/guide/chinese-input-method/cim119a8d473/mac)。

### 按文稿记忆输入法

1. 打开“系统设置” > “键盘”。
2. 在“文字输入”旁点击“编辑”。
3. 在左侧选择“所有输入法”。
4. 启用“自动切换到文稿的输入法”。

macOS 会把输入源与文稿关联，直到文稿关闭。它是“按文稿”而不是永久的“按应用程序”
规则。终端标签页、分栏、浏览器输入框以及没有标准文稿上下文的程序，实际支持情况可能
有所不同。

Apple 官方参考：
[在 Mac 上更改输入法设置](https://support.apple.com/zh-cn/guide/mac-help-cn/mchl84525d76/mac)。

### 在简体拼音中使用半角标点

1. 切换到“简体拼音”。
2. 点击 macOS 菜单栏中的输入法图标。
3. 选择“打开简体拼音设置”。
4. 启用“使用半角标点符号”。

对应的快捷键是 <kbd>Option</kbd> + <kbd>Shift</kbd> + <kbd>H</kbd>。

Apple 官方参考：
[在 Mac 上更改中文和粤语输入法的设置](https://support.apple.com/zh-cn/guide/chinese-input-method/cim21aa5fa50/mac)。

## 重新加载、暂停或退出

编辑脚本后：

1. 右键单击 AutoHotkey 托盘图标。
2. 选择“Reload Script”。

临时排错时可以使用“Pause Script”或“Suspend Hotkeys”；如需完全停止，选择“Exit”。

## 常见问题

### Caps Lock 没有在预期的两个输入法之间切换

删除不使用的键盘布局，或者用 <kbd>Win</kbd> + <kbd>Space</kbd> 查看当前输入配置。
<kbd>Alt</kbd> + <kbd>Shift</kbd> 的行为是循环切换，而不是按名称锁定两个输入法。

### 普通程序中有效，但管理员程序中无效

Windows 的权限边界可能阻止普通权限进程向管理员权限程序发送输入。让脚本和目标程序
运行在相同权限级别。除非确有必要，不建议让脚本始终以管理员身份运行。

### Caps Lock 仍然改变字母大小写

确认没有运行多个冲突的 AHK 脚本，并检查其他键盘管理软件是否也在修改 Caps Lock。
修改配置后重新加载脚本。

### 鼠标滚动方向相反

交换最后两行：

```ahk
XButton1::Send "{WheelUp 6}"
XButton2::Send "{WheelDown 6}"
```

### 浏览器仍然执行前进或后退

检查鼠标厂商的软件是否在 AutoHotkey 收到按键前直接执行导航。可以在厂商软件中取消
前进/后退功能，或者把硬件侧键设为普通的 `XButton1` 和 `XButton2`。

## 卸载

1. 从系统托盘退出正在运行的脚本。
2. 从 `shell:startup` 中删除脚本快捷方式或启动加载器。
3. 如果使用独立配置目录，删除 `.config\autohotkey` 中复制的脚本。
4. AutoHotkey 可以保留供其他脚本使用；如果不再需要，可在“设置” > “应用” >
   “已安装的应用”中卸载。

## 许可证

[MIT](LICENSE)
