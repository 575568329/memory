# 组合策略配置说明

> 会话结束自动推送 + 每天定时推送 + 重要记忆立即推送

---

## ✅ 已完成的配置

### 1. Git Hooks（会话结束自动推送）

**状态**：✅ 已配置

**位置**：`~/.adaptive-memory/.git/hooks/`

**功能**：
- `post-commit` - 提交后自动触发智能推送
- `post-merge` - 拉取后显示更新信息

**工作原理**：
```
你添加记忆
   ↓
自动提交到本地Git
   ↓
post-commit hook 触发
   ↓
运行 smart-push.sh
   ↓
智能判断推送策略
   ↓
自动推送到GitHub
```

---

### 2. 智能推送脚本

**位置**：`scripts/smart-push.sh`

**推送策略**：

| 优先级 | 触发条件 | 推送时机 | 示例 |
|--------|---------|----------|------|
| **高** | 核心记忆更改 | 立即推送 | MEMORY.md 修改 |
| **高** | 配置文件更改 | 立即推送 | CLAUDE.md 修改 |
| **高** | 决策记录添加 | 立即推送 | decisions/ 添加 |
| **中** | 5个以上文件 | 5秒后推送 | 批量更新 |
| **低** | 普通更新 | 根据时间 | 白天立即/深夜队列 |

**特殊处理**：
- 🌙 深夜时段（22:00-08:00）：低优先级加入队列
- 🌐 网络不可用：加入推送队列
- 📋 队列处理：定时任务会处理队列

---

### 3. 定时任务（待配置）

**状态**：⏳ 需要手动配置

**脚本**：`scripts/daily-sync.sh`

**功能**：
- 每天晚上10点自动执行
- 拉取远程更新
- 处理推送队列
- 推送本地更新
- 生成每日统计

**配置方法**：

**Linux/macOS**：
```bash
cd ~/.adaptive-memory
bash scripts/setup-schedule.sh
```

**Windows**：
1. 打开任务计划程序
2. 创建基本任务
3. 设置每天22:00执行
4. 运行：`bash scripts/daily-sync.sh`

---

### 4. 快速手动推送

**位置**：`scripts/quick-push.sh`

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

## 🎯 组合策略工作流程

### 日常使用

```
工作时：
├─ 正常使用 Claude Code
├─ 添加记忆（自动提交）
└─ 会话结束 → 自动推送
   └─ 智能判断优先级
      ├─ 重要 → 立即推送
      └─ 普通 → 5秒后推送

每天晚上10点：
├─ 定时任务触发
├─ 拉取远程更新
├─ 处理推送队列
├─ 推送本地更新
└─ 生成每日报告

重要时刻：
└─ 手动运行 quick-push.sh
   └─ 立即推送所有更改
```

---

## 📊 监控和管理

### 查看同步状态

```bash
# 查看未推送的提交
cd ~/.adaptive-memory
git log origin/main..HEAD

# 查看同步日志
tail -f ~/.memory-sync.log

# 查看推送队列
cat .push_queue
```

### 测试推送

```bash
# 测试智能推送
bash scripts/smart-push.sh

# 测试每日同步
bash scripts/daily-sync.sh

# 快速手动推送
bash scripts/quick-push.sh
```

---

## 🛠️ 配置步骤

### 步骤1：Git Hooks（已完成✅）

```bash
cd ~/.adaptive-memory
bash scripts/setup-hooks.sh
```

### 步骤2：定时任务（需要执行）

```bash
cd ~/.adaptive-memory
bash scripts/setup-schedule.sh
```

### 步骤3：测试配置

```bash
# 测试智能推送
bash scripts/smart-push.sh

# 测试每日同步
bash scripts/daily-sync.sh
```

---

## 💡 使用建议

### 推荐习惯

1. **工作开始前**
   ```bash
   git pull origin main  # 拉取最新更改
   ```

2. **添加重要记忆后**
   ```bash
   bash scripts/quick-push.sh  # 立即推送
   ```

3. **正常使用**
   ```bash
   # 不需要任何操作，自动处理
   ```

4. **切换设备前**
   ```bash
   bash scripts/quick-push.sh  # 确保同步
   ```

### 便捷命令

可以添加到 `~/.bashrc` 或 `~/.zshrc`：

```bash
# 记忆系统快捷命令
alias memory-push='cd ~/.adaptive-memory && bash scripts/quick-push.sh'
alias memory-sync='cd ~/.adaptive-memory && bash scripts/daily-sync.sh'
alias memory-status='cd ~/.adaptive-memory && git status'
alias memory-log='tail -f ~/.memory-sync.log'
```

---

## 🔧 故障排查

### Git hooks 不工作

```bash
# 检查 hooks 配置
ls -la .git/hooks/

# 重新配置
bash scripts/setup-hooks.sh

# 手动测试
bash .git/hooks/post-commit
```

### 定时任务不执行

```bash
# 检查 crontab
crontab -l

# 查看日志
cat ~/.memory-sync.log

# 手动测试
bash scripts/daily-sync.sh
```

### 推送失败

```bash
# 检查网络
ping github.com

# 检查远程仓库
git remote -v

# 手动推送
git push origin main
```

---

## 📚 相关文档

- [脚本使用说明](scripts/README.md) - 详细使用指南
- [维护指南](docs/MAINTENANCE.md) - 系统维护最佳实践
- [FAQ](docs/FAQ.md) - 常见问题解答

---

## 🎉 配置完成

你现在拥有：

- ✅ **会话结束自动推送** - Git hooks 已配置
- ⏳ **每天定时推送** - 需要配置定时任务
- ✅ **快速手动推送** - quick-push.sh 可用

**下一步**：配置定时任务，让组合策略完全生效！

```bash
cd ~/.adaptive-memory
bash scripts/setup-schedule.sh
```

---

**最后更新**：2026-03-26
**维护者**：记忆管理器
