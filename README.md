# 🚀 Init-Mac

<p align="center">
  <img src="https://user-images.githubusercontent.com/12573233/236685567-5b4c9ae5-f222-4fdb-b1bf-b536d2cc0c0c.png" alt="Init-Mac Logo" width="200">
</p>

<p align="center">
  <strong>一键配置 macOS 开发环境的终极脚本</strong>
</p>

<p align="center">
  <a href="#-特性">✨ 特性</a> •
  <a href="#-安装">🔧 安装</a> •
  <a href="#-使用方法">📖 使用方法</a> •
  <a href="#-包含工具">🛠️ 包含工具</a> •
  <a href="#-自定义">⚙️ 自定义</a> •
  <a href="#-贡献">👥 贡献</a> •
  <a href="#-许可证">📄 许可证</a>
</p>

<p align="center">
  <a href="https://github.com/jarvislin94/Init-Mac/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/jarvislin94/Init-Mac" alt="License">
  </a>
  <img src="https://img.shields.io/badge/platform-macOS-lightgrey" alt="Platform">
  <img src="https://img.shields.io/badge/shell-bash-4EAA25" alt="Shell">
  <img src="https://img.shields.io/badge/macOS-Monterey%20|%20Ventura%20|%20Sonoma-blue" alt="macOS">
</p>

*中文 | [English](README.en.md)*

---

## ✨ 特性

Init-Mac 是一个全面的 macOS 开发环境配置脚本，专为开发者设计，可以在几分钟内完成新 Mac 的开发环境设置。

- 🚀 **一键安装** - 一个命令设置所有开发工具和配置
- 🎨 **美观的界面** - 彩色输出和清晰的进度指示
- 🔄 **幂等操作** - 可以安全地多次运行，不会重复安装
- 🔧 **全面的工具集** - 包含前端、后端、移动和云开发所需的所有工具
- 🎛️ **交互式选项** - 可以选择安装哪些应用程序和配置
- 💻 **支持 Intel 和 Apple Silicon** - 自动检测并适配不同的 Mac 芯片
- 🔒 **安全可靠** - 使用官方源和安全的安装方法

<p align="center">
  <img src="https://user-images.githubusercontent.com/12573233/236685568-5b4c9ae5-f222-4fdb-b1bf-b536d2cc0c0d.gif" alt="Init-Mac Demo" width="600">
</p>

## 🔧 安装

只需一行命令即可下载并运行 Init-Mac：

```bash
curl -fsSL https://raw.githubusercontent.com/jarvislin94/Init-Mac/main/init.sh | bash
```

或者，您也可以先下载脚本，然后再运行：

```bash
# 克隆仓库
git clone https://github.com/jarvislin94/Init-Mac.git

# 进入目录
cd Init-Mac

# 赋予执行权限
chmod +x init.sh

# 运行脚本
./init.sh
```

## 📖 使用方法

运行脚本后，您将看到一个交互式界面，引导您完成整个设置过程：

1. 脚本将首先安装基本工具，如 Homebrew、Git 和 Xcode Command Line Tools
2. 然后，它会设置您的 Git 配置并生成 SSH 密钥
3. 接下来，它会安装开发工具，如 VS Code、Node.js、Docker 等
4. 您可以选择安装额外的应用程序，如 Chrome、Slack、Postman 等
5. 最后，您可以选择配置 macOS 系统设置，优化开发体验

脚本执行过程中会显示彩色输出，清晰指示当前进度和成功/失败状态。

## 🛠️ 包含工具

Init-Mac 包含以下开发工具和应用程序：

### 基础工具
- **Homebrew** - macOS 包管理器
- **Git** - 版本控制系统
- **Xcode Command Line Tools** - 基本开发工具

### 开发环境
- **Visual Studio Code** - 代码编辑器，包含常用扩展
- **iTerm2** - 终端模拟器
- **Oh My Zsh** - Zsh 配置框架，包含 Powerlevel10k 主题和插件
- **Docker** - 容器化平台

### 编程语言和运行时
- **Node.js** (通过 NVM) - JavaScript 运行时
- **Python** - 编程语言
- **Go** - 编程语言
- **Rust** - 编程语言

### 数据库工具
- **PostgreSQL** - 关系型数据库
- **MySQL** - 关系型数据库
- **SQLite** - 轻量级数据库

### 云工具
- **AWS CLI** - Amazon Web Services 命令行工具
- **Terraform** - 基础设施即代码工具

### 命令行工具
- **jq** - JSON 处理器
- **ripgrep** - 快速搜索工具
- **fd** - 快速查找工具
- **bat** - 增强的 cat 命令
- **exa** - 增强的 ls 命令
- **htop** - 进程查看器
- **tmux** - 终端复用器
- **fzf** - 模糊查找器
- 以及更多...

### 可选应用程序
- **Google Chrome** - 网络浏览器
- **Firefox** - 网络浏览器
- **Slack** - 团队协作工具
- **Postman** - API 测试工具
- **Rectangle** - 窗口管理工具
- **Alfred** - 生产力工具
- **Notion** - 笔记和协作工具
- **Obsidian** - 知识管理工具
- **Figma** - 设计工具

## ⚙️ 自定义

您可以通过编辑 `init.sh` 文件来自定义安装过程：

- 添加或删除要安装的工具和应用程序
- 修改 Git 配置和 SSH 密钥生成
- 调整 VS Code 扩展
- 更改 macOS 系统设置

未来版本将支持通过配置文件进行更灵活的自定义。

## 👥 贡献

欢迎贡献！如果您有改进建议或发现了问题，请：

1. Fork 这个仓库
2. 创建您的特性分支 (`git checkout -b feature/amazing-feature`)
3. 提交您的更改 (`git commit -m 'Add some amazing feature'`)
4. 推送到分支 (`git push origin feature/amazing-feature`)
5. 创建一个 Pull Request

## 📄 许可证

该项目采用 MIT 许可证 - 详情请参阅 [LICENSE](LICENSE) 文件。

---

<p align="center">
  <sub>Made with ❤️ by <a href="https://github.com/jarvislin94">jarvislin94</a></sub>
</p>