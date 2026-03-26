# 快速开始指南

> 在新设备上快速部署自适应记忆层

---

## 📦 前置要求

### 必需软件

- **Git**：版本控制
- **Claude Code**：AI 编程助手
- **Bash**：命令行工具（Windows 可用 Git Bash）

### 账号准备

- **GitHub 账号**
- **仓库访问权限**：https://github.com/575568329/memory

---

## 🚀 三步快速部署

### 步骤1：克隆仓库

```bash
# 克隆记忆仓库
git clone https://github.com/575568329/memory.git ~/.adaptive-memory

# 进入目录
cd ~/.adaptive-memory
```

### 步骤2：运行初始化脚本

```bash
# 自动配置 Claude Code
bash config/setup.sh
```

**脚本会自动完成**：
- ✅ 备份现有配置
- ✅ 复制配置文件
- ✅ 设置文件权限
- ✅ 验证配置正确性
- ✅ 可选：创建符号链接

### 步骤3：重启 Claude Code

```bash
# 完全退出 Claude Code
# 重新启动应用
```

---

## ✅ 验证部署

### 测试1：检查配置

```bash
# 检查 CLAUDE.md
cat ~/.claude/CLAUDE.md | grep "记忆系统集成"

# 检查 skill
ls -la ~/.claude/skills/memory-manager/
```

**期望输出**：
```
✅ 找到"记忆系统集成"章节
✅ memory-manager 目录存在
```

### 测试2：测试记忆系统

在 Claude Code 中说：

```
记住，我偏好使用 TypeScript 而不是 JavaScript
```

**期望行为**：
- 🤖 AI 自动触发记忆管理器
- 📋 展示提取建议
- ✅ 请求用户确认
- 💾 写入记忆文件

### 测试3：验证同步

```bash
cd ~/.adaptive-memory
git status
```

**期望输出**：
```
 Changes not staged for commit:
   modified:   MEMORY.md
   new file:   memory/preferences/coding-style.md
```

---

## 🔄 日常使用

### 自动同步

记忆系统会自动同步：

```
本地修改 → 自动提交 → 自动推送 → 其他设备自动拉取
```

### 手动同步

如果需要立即同步：

```bash
cd ~/.adaptive-memory
git pull origin main    # 拉取更新
git push origin main    # 推送更新
```

### 查看记忆

```bash
# 查看核心记忆
cat ~/.adaptive-memory/MEMORY.md

# 查看分类记忆
ls -la ~/.adaptive-memory/memory/preferences/

# 查看评分记录
cat ~/.adaptive-memory/state/scores.json
```

---

## 🔧 高级配置

### 配置定时同步

**Linux/Mac (crontab)**：
```bash
# 每30分钟同步一次
crontab -e

# 添加以下行
*/30 * * * * cd ~/.adaptive-memory && git pull origin main && git push origin main
```

**Windows (Task Scheduler)**：
```powershell
# 创建定时任务
$action = New-ScheduledTaskAction -Execute "bash" -Argument "C:\Users\fjyu9\.adaptive-memory\scripts\sync-memory.sh"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "SyncMemory"
```

### 配置 Git Hooks

**自动提交后同步**：
```bash
# ~/.adaptive-memory/.git/hooks/post-commit
#!/bin/bash
git push origin main &
```

**自动拉取后更新**：
```bash
# ~/.adaptive-memory/.git/hooks/post-merge
#!/bin/bash
bash config/setup.sh
```

---

## 📱 多设备使用

### 设备A（主要开发机）

```bash
# 1. 初始化（首次）
git clone https://github.com/575568329/memory.git ~/.adaptive-memory
bash config/setup.sh

# 2. 日常使用
# 正常使用，系统会自动同步
```

### 设备B（笔记本/其他设备）

```bash
# 1. 克隆仓库
git clone https://github.com/575568329/memory.git ~/.adaptive-memory

# 2. 运行初始化
cd ~/.adaptive-memory
bash config/setup.sh

# 3. 拉取最新记忆
git pull origin main

# 4. 重启 Claude Code
```

### 冲突处理

如果多设备同时编辑：

```bash
# 1. 拉取时检测冲突
git pull origin main

# 2. 手动解决冲突
# Git 会标记冲突文件

# 3. 提交解决
git add .
git commit -m "resolve: 解决合并冲突"
git push origin main
```

---

## 🐛 故障排查

### 问题1：Skill 未被识别

**症状**：说"记住..."没有反应

**解决**：
```bash
# 1. 检查 skill 文件
ls -la ~/.claude/skills/memory-manager/

# 2. 检查 skill 格式
head -5 ~/.claude/skills/memory-manager/skill.md

# 3. 重新运行 setup.sh
cd ~/.adaptive-memory
bash config/setup.sh

# 4. 重启 Claude Code
```

### 问题2：配置未生效

**症状**：记忆系统不工作

**解决**：
```bash
# 1. 检查 CLAUDE.md
cat ~/.claude/CLAUDE.md | grep "记忆系统集成"

# 2. 检查文件权限
chmod 644 ~/.claude/CLAUDE.md
chmod 644 ~/.claude/skills/memory-manager/skill.md

# 3. 清除缓存
rm -rf ~/.claude/cache/

# 4. 重启 Claude Code
```

### 问题3：Git 同步失败

**症状**：无法推送到 GitHub

**解决**：
```bash
# 1. 检查网络连接
ping github.com

# 2. 检查远程仓库
git remote -v

# 3. 重新配置远程
git remote set-url origin https://github.com/575568329/memory.git

# 4. 测试连接
git push origin main --dry-run
```

### 问题4：符号链接失效

**症状**：配置文件找不到

**解决**：
```bash
# 1. 检查链接状态
ls -la ~/.claude/CLAUDE.md

# 2. 重新创建链接
cd ~/.adaptive-memory
bash config/setup.sh

# 选择 "y" 创建符号链接
```

---

## 📚 更多资源

### 文档

- **完整方案**：查看桌面上的 `跨设备自适应记忆层设计方案.md`
- **配置说明**：查看 `config/README.md`
- **测试报告**：查看 `TEST_REPORT.md`

### GitHub 仓库

- **仓库地址**：https://github.com/575568329/memory
- **Issue 跟踪**：报告问题和建议
- **Wiki 文档**：更多使用技巧

### 更新日志

- **v1.0.0** (2026-03-26)：初始版本
  - ✅ 记忆提取和评分
  - ✅ 跨设备同步
  - ✅ 配置管理
  - ✅ 冲突处理

---

## 🎉 成功标志

当你看到以下现象时，说明部署成功：

- ✅ `MEMORY.md` 存在且内容完整
- ✅ `memory/preferences/` 目录有文件
- ✅ 说"记住..."会自动触发
- ✅ Git 日志有提交记录
- ✅ 多设备内容一致

---

**祝你使用愉快！** 🚀

---

**最后更新**：2026-03-26
**维护者**：记忆管理器
