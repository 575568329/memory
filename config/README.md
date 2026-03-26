# Claude Code 配置文件

> 此目录包含跨设备同步的配置文件

---

## 📁 目录结构

```
config/
├── CLAUDE.md              # Claude Code 全局配置
├── skills/
│   └── memory-manager/    # 记忆管理器 skill
│       └── skill.md       # skill 定义
└── setup.sh               # 自动初始化脚本
```

---

## 🔧 配置说明

### CLAUDE.md

**用途**：Claude Code 的全局配置文件

**包含内容**：
- 编码规范（Java、Python、前端）
- 工作流程（TDD、任务分解）
- **记忆系统集成**（第八章）
- 协作备忘

**目标位置**：`~/.claude/CLAUDE.md`

### memory-manager skill

**用途**：自动管理记忆系统的 skill

**触发条件**：
- 用户说"记住"、"记录"
- 检测到重复模式（3次+）
- 会话结束时自动提取
- 每周日晚上8点周总结

**目标位置**：`~/.claude/skills/memory-manager/skill.md`

---

## 🚀 新设备设置

### 方法1：自动初始化（推荐）

```bash
cd ~/.adaptive-memory/config
bash setup.sh
```

### 方法2：手动设置

```bash
# 复制 CLAUDE.md
cp config/CLAUDE.md ~/.claude/CLAUDE.md

# 复制 skill
mkdir -p ~/.claude/skills
cp -r config/skills/memory-manager ~/.claude/skills/

# 重启 Claude Code
```

### 方法3：符号链接（可选）

```bash
# 创建符号链接（需要管理员权限）
ln -s ~/.adaptive-memory/config/CLAUDE.md ~/.claude/CLAUDE.md
ln -s ~/.adaptive-memory/config/skills/memory-manager ~/.claude/skills/memory-manager
```

---

## 🔄 配置同步

### 自动同步

配置文件会随记忆库一起同步到 GitHub：
```
本地修改 → git commit → git push → 其他设备 git pull
```

### 冲突处理

如果配置文件在多设备上同时修改：

1. **Git 会检测冲突**
2. **手动合并配置**
3. **重新运行 setup.sh**

### 配置更新流程

```
1. 在设备A修改配置
   ↓
2. 提交到 Git
   ↓
3. 推送到 GitHub
   ↓
4. 设备B 拉取更新
   ↓
5. 重新运行 setup.sh
```

---

## ⚠️ 注意事项

### 配置冲突

- **记忆系统配置**（第八章）：应该在所有设备上保持一致
- **个人偏好**（其他章节）：可以根据设备特性调整

### 版本兼容性

- **Claude Code 版本**：确保所有设备使用相同版本
- **Skill API**：skill 定义可能随 Claude Code 更新而变化

### 安全性

- **不要在 CLAUDE.md 中记录敏感信息**（API密钥、密码）
- **Git 仓库应该是私有的**
- **定期检查提交历史**，避免误提交敏感信息

---

## 📝 配置修改建议

### 修改配置前

1. **先拉取最新版本**
   ```bash
   cd ~/.adaptive-memory
   git pull origin main
   ```

2. **备份当前配置**
   ```bash
   cp ~/.claude/CLAUDE.md ~/.claude/CLAUDE.md.backup
   ```

### 修改配置后

1. **测试配置是否生效**
   ```bash
   # 重启 Claude Code
   # 检查 skill 是否被识别
   ```

2. **同步到其他设备**
   ```bash
   cd ~/.adaptive-memory
   git add config/
   git commit -m "config: 更新配置"
   git push origin main
   ```

3. **在其他设备上更新**
   ```bash
   cd ~/.adaptive-memory
   git pull origin main
   bash config/setup.sh
   ```

---

## 🔍 故障排查

### Skill 未被识别

```bash
# 检查 skill 文件是否存在
ls -la ~/.claude/skills/memory-manager/

# 检查 skill 文件格式
head -10 ~/.claude/skills/memory-manager/skill.md

# 重启 Claude Code
```

### 配置未生效

```bash
# 检查 CLAUDE.md 是否存在
ls -la ~/.claude/CLAUDE.md

# 检查文件权限
chmod 644 ~/.claude/CLAUDE.md

# 重新运行 setup.sh
cd ~/.adaptive-memory/config
bash setup.sh
```

### 符号链接失效

```bash
# 检查链接状态
ls -la ~/.claude/CLAUDE.md

# 重新创建链接
rm ~/.claude/CLAUDE.md
ln -s ~/.adaptive-memory/config/CLAUDE.md ~/.claude/CLAUDE.md
```

---

**最后更新**：2026-03-26
**维护者**：记忆管理器
