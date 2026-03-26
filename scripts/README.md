# 自动化脚本使用说明

> 组合策略的完整配置和使用指南

---

## 📋 脚本列表

### 1. smart-push.sh - 智能推送脚本

**功能**：根据更改重要性自动决定推送策略

**特点**：
- ⭐ 核心记忆更改 → 立即推送
- ⏰ 中等优先级 → 5秒后推送
- 🌙 低优先级/深夜 → 加入推送队列
- 🌐 网络检查 → 失败时加入队列

**使用方法**：
```bash
cd ~/.adaptive-memory
bash scripts/smart-push.sh
```

---

### 2. daily-sync.sh - 每日定时推送

**功能**：每天晚上10点自动执行完整同步

**包含内容**：
- 📥 拉取远程更新
- 📋 处理推送队列
- 📤 推送本地更新
- 📊 生成每日统计
- 🧹 清理临时文件

**使用方法**：
```bash
cd ~/.adaptive-memory
bash scripts/daily-sync.sh
```

**配置定时任务**：
```bash
# 运行配置脚本
bash scripts/setup-schedule.sh
```

---

### 3. setup-hooks.sh - Git Hooks 配置

**功能**：配置 Git hooks 实现会话结束自动推送

**配置的钩子**：
- `post-commit` - 提交后自动触发智能推送
- `post-merge` - 拉取后显示更新信息

**使用方法**：
```bash
cd ~/.adaptive-memory
bash scripts/setup-hooks.sh
```

---

### 4. setup-schedule.sh - 定时任务配置

**功能**：自动配置系统的定时任务

**支持平台**：
- ✅ Linux (crontab)
- ✅ macOS (crontab)
- ⚠️  Windows (任务计划程序，需手动配置)

**使用方法**：
```bash
cd ~/.adaptive-memory
bash scripts/setup-schedule.sh
```

---

### 5. quick-push.sh - 快速手动推送

**功能**：重要记忆立即手动推送

**使用场景**：
- 添加了重要决策
- 需要立即同步到其他设备
- 不想等待自动推送

**使用方法**：
```bash
cd ~/.adaptive-memory
bash scripts/quick-push.sh
```

---

## 🚀 快速配置

### 一次性完整配置

```bash
cd ~/.adaptive-memory

# 1. 配置 Git hooks（会话结束自动推送）
bash scripts/setup-hooks.sh

# 2. 配置定时任务（每天晚上10点推送）
bash scripts/setup-schedule.sh

# 3. 完成配置
echo "✅ 组合策略配置完成！"
```

---

## 🔄 组合策略工作流程

### 日常使用

```
工作时：
├─ 正常使用 Claude Code
├─ 添加记忆（自动提交到本地）
└─ 会话结束 → post-commit hook 触发
   └─ smart-push.sh 智能推送

每天晚上10点：
├─ crontab 触发 daily-sync.sh
├─ 拉取远程更新
├─ 推送本地更新
└─ 生成每日报告

重要时刻：
├─ 添加重要决策
└─ 手动运行 quick-push.sh
   └─ 立即推送
```

### 推送优先级

```
高优先级（立即推送）：
├─ MEMORY.md 修改
├─ config/CLAUDE.md 修改
└─ memory/decisions/ 添加

中优先级（5秒后推送）：
└─ 5个以上文件修改

低优先级（定时推送）：
└─ 普通记忆更新
   ├─ 白天：立即推送
   └─ 深夜：加入队列
```

---

## 📊 监控和日志

### 查看同步日志

```bash
# 查看定时任务日志
tail -f ~/.memory-sync.log

# 查看最近的同步记录
tail -20 ~/.memory-sync.log
```

### 检查推送队列

```bash
cd ~/.adaptive-memory

# 查看待推送任务
cat .push_queue

# 清空推送队列
rm -f .push_queue
```

### 查看同步状态

```bash
cd ~/.adaptive-memory

# 查看未推送的提交
git log origin/main..HEAD

# 查看同步状态
git status
```

---

## 🛠️ 故障排查

### 问题1：定时任务不执行

**检查 crontab**：
```bash
crontab -l
```

**检查日志**：
```bash
cat ~/.memory-sync.log
```

**手动测试**：
```bash
bash scripts/daily-sync.sh
```

### 问题2：Git hooks 不触发

**检查 hooks 配置**：
```bash
ls -la .git/hooks/
```

**手动测试**：
```bash
bash .git/hooks/post-commit
```

**重新配置**：
```bash
bash scripts/setup-hooks.sh
```

### 问题3：推送失败

**检查网络**：
```bash
ping github.com
```

**检查远程仓库**：
```bash
git remote -v
```

**手动推送**：
```bash
git push origin main
```

---

## 💡 使用技巧

### 技巧1：创建便捷命令

```bash
# 添加到 ~/.bashrc 或 ~/.zshrc
alias memory-push='cd ~/.adaptive-memory && bash scripts/quick-push.sh'
alias memory-sync='cd ~/.adaptive-memory && bash scripts/daily-sync.sh'
alias memory-status='cd ~/.adaptive-memory && git status'
```

### 技巧2：重要记忆立即推送

```bash
# 添加重要决策后
memory-push  # 立即推送
```

### 技巧3：查看同步历史

```bash
# 查看最近的推送记录
cd ~/.adaptive-memory
git log --oneline -10
```

### 技巧4：强制立即推送

```bash
# 忽略优先级，立即推送所有更改
cd ~/.adaptive-memory
git push origin main --force
```

---

## 🎯 最佳实践

### 推荐配置

```bash
# 1. Git hooks（必选）
bash scripts/setup-hooks.sh

# 2. 定时任务（推荐）
bash scripts/setup-schedule.sh

# 3. 快捷命令（可选）
# 添加到 ~/.bashrc
alias memory-push='...'
```

### 推荐使用习惯

1. **工作开始前**：
   ```bash
   git pull origin main  # 拉取最新更改
   ```

2. **添加重要记忆后**：
   ```bash
   memory-push  # 立即推送
   ```

3. **工作结束后**：
   ```bash
   # 不需要操作，自动处理
   ```

4. **切换设备前**：
   ```bash
   memory-push  # 确保所有更改已推送
   ```

---

## 📚 相关文档

- [维护指南](../docs/MAINTENANCE.md) - 系统维护最佳实践
- [FAQ](../docs/FAQ.md#同步) - 同步相关问题
- [最佳实践](../docs/BEST_PRACTICES.md) - 高效使用技巧

---

**最后更新**：2026-03-26
**维护者**：记忆管理器
