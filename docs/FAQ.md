# 常见问题解答（FAQ）

> 自适应记忆层使用中的常见问题

---

## 📚 基础问题

### Q1: 什么是自适应记忆层？

**A**: 一个智能化的个人记忆管理系统，具有以下特性：

- ✅ **跨设备同步**：通过GitHub私有仓库实现多设备访问
- ✅ **半自动维护**：AI辅助提取关键信息，用户审核确认
- ✅ **智能化管理**：自动冲突检测、定期总结、重要性评分
- ✅ **精简高效**：不占用过多上下文，持续抽象优化

### Q2: 我需要什么前提条件？

**A**: 必需项：

1. **Git** - 版本控制
2. **Claude Code** - AI编程助手
3. **GitHub账号** - 远程仓库
4. **Bash** - 命令行工具（Windows可用Git Bash）

可选项：
- 多台设备（单设备也可使用）
- 定时任务配置（自动同步）

### Q3: 如何快速开始？

**A**: 只需3步：

```bash
# 1. 克隆仓库
git clone https://github.com/575568329/memory.git ~/.adaptive-memory

# 2. 运行初始化
cd ~/.adaptive-memory
bash config/setup.sh

# 3. 重启Claude Code
```

详见：[快速开始指南](../QUICK_START.md)

---

## 🤖 使用问题

### Q4: 如何触发记忆管理器？

**A**: 三种方式：

**方式1：显式触发**（最直接）
```
说："记住，我偏好使用TypeScript"
```

**方式2：隐式触发**（自动检测）
```
AI检测到你3次以上提到同一偏好
会自动触发记忆管理器
```

**方式3：定时触发**（自动化）
```
- 会话结束前5分钟：自动提取
- 每周日晚上8点：周总结
```

### Q5: 记忆会自动创建吗？

**A**: 不会，需要用户确认：

```
AI提取 → 展示建议 → 用户确认 → 创建记忆
```

这是**半自动**设计，保证准确性：
- ✅ 避免错误记录
- ✅ 保持用户控制权
- ✅ 反馈闭环改进

### Q6: 如何查看已保存的记忆？

**A**: 三个位置：

**1. 核心记忆**（最重要）
```bash
cat ~/.adaptive-memory/MEMORY.md
```

**2. 分类记忆**（详细）
```bash
ls -la ~/.adaptive-memory/memory/preferences/
ls -la ~/.adaptive-memory/memory/decisions/
```

**3. 评分记录**（统计）
```bash
cat ~/.adaptive-memory/state/scores.json
```

### Q7: 如何修改已保存的记忆？

**A**: 两种方式：

**方式1：通过Claude Code**
```
说："修改我的编码偏好，现在使用..."
```

**方式2：手动编辑**
```bash
# 编辑对应文件
vim ~/.adaptive-memory/memory/preferences/coding-style.md

# 提交更改
cd ~/.adaptive-memory
git add . && git commit -m "update: 修改编码偏好"
```

### Q8: 如何删除不需要的记忆？

**A**: 根据重要性：

**高分记忆（≥7分）**：
```bash
# 1. 先归档
mv memory/preferences/old-preference.md memory/archive/2026/03/

# 2. 从MEMORY.md中移除
# 3. 提交更改
git add . && git commit -m "archive: 归档过时偏好"
```

**低分记忆（<4分）**：
```bash
# 直接删除
rm memory/preferences/unimportant.md

# 更新评分
git add . && git commit -m "delete: 删除低分记忆"
```

---

## 🔄 同步问题

### Q9: 多设备如何保持同步？

**A**: 自动同步机制：

```
设备A：修改记忆 → git commit → git push
    ↓
GitHub：中央仓库
    ↓
设备B：git pull → 自动更新
```

**同步频率**：
- 自动：每30分钟（可配置）
- 手动：随时运行 `git pull/push`
- 即时：修改后立即推送

### Q10: 如果同时编辑会冲突吗？

**A**: 会的，但有解决机制：

**检测冲突**：
```bash
git pull origin main
# CONFLICT (content): Merge conflict in MEMORY.md
```

**解决方法**：
1. **自动解决**：脚本会尝试智能合并
2. **手动解决**：查看冲突标记，选择保留版本
3. **用户选择**：AI提供3种解决方案

详见：[冲突解决指南](#冲突处理)

### Q11: GitHub无法访问怎么办？

**A**: 多个备用方案：

**方案1：使用镜像**
```bash
git clone https://mirror.ghproxy.com/https://github.com/575568329/memory.git
```

**方案2：切换平台**
```bash
# 切换到GitLab/Gitee
git remote set-url origin https://gitee.com/xxx/memory.git
```

**方案3：本地降级**
```bash
# 暂停同步，仅使用本地存储
# 等网络恢复后再同步
```

### Q12: 如何在断网环境下使用？

**A**: 完全可以使用：

```
断网环境：
├── 读取记忆 ✅（本地文件）
├── 创建记忆 ✅（本地Git）
├── 修改记忆 ✅（本地Git）
└── 同步记忆 ❌（需要网络）

恢复网络后：
└── git push → 推送所有本地更改
```

---

## 🔒 安全问题

### Q13: 我的隐私安全吗？

**A**: 多重保护措施：

**1. 私有仓库**
```bash
GitHub私有仓库：仅你可见
访问权限：已授权用户
```

**2. .gitignore保护**
```gitignore
# 排除敏感信息
state/
*.secret
*.key
*.token
```

**3. 内容审查**
```bash
# 提交前检查敏感词
pre-commit hook 检测API密钥、密码等
```

**4. 手动审查**
```
所有记录需用户确认
避免误提交敏感信息
```

### Q14: 应该避免记录什么？

**A**: 禁止记录：

**敏感信息**：
- ❌ API密钥和密码
- ❌ 个人身份信息（身份证、护照）
- ❌ 银行账号和信用卡
- ❌ 临时凭证和token

**不合适内容**：
- ❌ 一次性临时信息
- ❌ 毫无意义的对话
- ❌ 他人隐私信息

**适合记录**：
- ✅ 编码偏好和习惯
- ✅ 技术决策和选择
- ✅ 工作流程和方法
- ✅ 调试经验和解决方案

### Q15: 如果误提交了敏感信息怎么办？

**A**: 紧急处理：

```bash
# 1. 立即删除敏感文件
git rm --cached sensitive_file.md

# 2. 修改历史（使用git filter-repo）
git filter-repo --invert-paths --path sensitive_file.md

# 3. 强制推送
git push origin master --force

# 4. 修改密码和密钥
# 如果已泄露，立即更换
```

**预防措施**：
```bash
# 安装git-secrets
git secrets --install
git secrets --register-aws

# 添加自定义规则
git secrets --add 'api_key\s*='
git secrets --add 'password\s*='
```

---

## 💾 性能问题

### Q16: 记忆会无限增长吗？

**A**: 不会，有控制机制：

**1. 重要性评分**
```
低分记忆（<4分）自动归档或删除
```

**2. 定期清理**
```
每月：归档6个月未访问的记忆
每季：清理重复或过时记忆
```

**3. 硬性限制**
```
MEMORY.md：严格<200行
总记忆数：建议<1000条
```

### Q17: 系统会影响性能吗？

**A**: 影响很小：

**内存占用**：
- 检索时间：<1秒
- 内存使用：<10MB
- 仓库大小：<50MB

**性能优化**：
- 仅加载核心记忆（MEMORY.md前200行）
- 按需加载详细记忆
- Git增量同步

**对比**：
```
传统方案：每次加载全部记忆
记忆系统：按需加载，性能更好
```

### Q18: 如何保持记忆系统高效？

**A**: 定期维护：

**每周**（5分钟）：
```bash
# 查看周总结
cat memory/weekly_summary.md

# 确认新记忆准确性
# 标记重要记忆
```

**每月**（15分钟）：
```bash
# 归档低分记忆
bash scripts/archive-memory.sh --score <4

# 合并重复记忆
bash scripts/merge-duplicates.sh
```

**每季**（30分钟）：
```bash
# 全面审查记忆
bash scripts/audit-memory.sh

# 清理过时内容
# 优化评分算法
```

---

## 🛠️ 技术问题

### Q19: 支持哪些操作系统？

**A**: 全平台支持：

| 系统 | 支持程度 | 说明 |
|------|---------|------|
| **Windows** | ✅ 完全支持 | Git Bash或WSL |
| **macOS** | ✅ 完全支持 | 原生Bash |
| **Linux** | ✅ 完全支持 | 原生Bash |

**Windows注意**：
```bash
# 推荐使用Git Bash
# 或WSL（Windows Subsystem for Linux）

# 符号链接需要管理员权限
# 或使用复制模式
```

### Q20: Skill没有被识别怎么办？

**A**: 排查步骤：

**1. 检查文件存在**
```bash
ls -la ~/.claude/skills/memory-manager/
```

**2. 检查文件格式**
```bash
head -5 ~/.claude/skills/memory-manager/skill.md
# 应该看到 ---
```

**3. 检查文件权限**
```bash
chmod 644 ~/.claude/skills/memory-manager/skill.md
```

**4. 重新运行setup**
```bash
cd ~/.adaptive-memory
bash config/setup.sh
```

**5. 重启Claude Code**
```
完全退出并重新启动
```

### Q21: 如何配置自动同步？

**A**: 三个平台的方法：

**Linux/Mac (crontab)**：
```bash
crontab -e

# 每30分钟同步
*/30 * * * * cd ~/.adaptive-memory && git pull origin main && git push origin main
```

**Windows (Task Scheduler)**：
```powershell
$action = New-ScheduledTaskAction -Execute "bash" -Argument "C:\Users\fjyu9\.adaptive-memory\scripts\sync-memory.sh"
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 30)
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "SyncMemory"
```

**Git Hooks**：
```bash
# ~/.adaptive-memory/.git/hooks/post-commit
#!/bin/bash
git push origin main &
```

---

## 📈 进阶问题

### Q22: 可以自定义评分算法吗？

**A**: 可以，修改脚本：

```bash
# 编辑评分脚本
vim ~/.adaptive-memory/scripts/importance-score.sh

# 调整权重
score = (
    frequency * 0.4 +    # 增加频率权重
    recency * 0.2 +      # 减少时效权重
    user_rating * 0.3 +  # 保持用户权重
    context * 0.1        # 保持上下文权重
)
```

**测试新算法**：
```bash
bash scripts/importance-score.sh --test
```

### Q23: 可以导出记忆数据吗？

**A**: 可以，多种格式：

**Markdown格式**：
```bash
# 已是Markdown格式，直接使用
cat ~/.adaptive-memory/MEMORY.md
```

**JSON格式**：
```bash
# 导出评分数据
cat ~/.adaptive-memory/state/scores.json

# 导出完整记忆
bash scripts/export-memory.sh --format json
```

**PDF格式**：
```bash
# 使用pandoc转换
pandoc MEMORY.md -o memory.pdf
```

### Q24: 可以搜索记忆吗？

**A**: 可以，多种方式：

**Grep搜索**：
```bash
# 搜索关键词
cd ~/.adaptive-memory
grep -r "TypeScript" memory/
```

**Git日志搜索**：
```bash
# 搜索提交历史
git log --grep="TypeScript" --oneline
```

**未来功能**：
- 语义检索（向量数据库）
- 全文索引
- Web UI搜索界面

### Q25: 如何贡献改进？

**A**: 欢迎贡献！

**报告问题**：
```
GitHub Issues：https://github.com/575568329/memory/issues
```

**提交改进**：
```bash
# 1. Fork仓库
# 2. 创建分支
git checkout -b feature/new-feature

# 3. 提交更改
git commit -m "feat: 添加新功能"

# 4. 推送到Fork
git push origin feature/new-feature

# 5. 创建Pull Request
```

**讨论建议**：
```
GitHub Discussions：讨论想法和建议
```

---

## 🔗 相关链接

### 文档
- [快速开始](../QUICK_START.md)
- [最佳实践](./BEST_PRACTICES.md)
- [配置说明](../config/README.md)

### 仓库
- [GitHub仓库](https://github.com/575568329/memory)
- [问题跟踪](https://github.com/575568329/memory/issues)
- [更新日志](../CHANGELOG.md)

### 外部资源
- [Claude Code文档](https://docs.anthropic.com/)
- [Git参考手册](https://git-scm.com/doc)

---

**最后更新**：2026-03-26
**版本**：v1.0.0
