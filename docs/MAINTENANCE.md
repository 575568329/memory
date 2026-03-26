# 记忆系统维护指南

> 保持记忆系统健康高效的最佳实践

---

## 📋 维护概述

### 维护目标

- ✅ **保持准确性**：记忆内容与实际偏好一致
- ✅ **控制规模**：防止记忆无限膨胀
- ✅ **提升效率**：快速检索和加载
- ✅ **确保安全**：保护敏感信息

### 维护周期

```
日常（自动）：AI提取和评分
每周（5分钟）：查看周总结
每月（15分钟）：归档和清理
每季（30分钟）：全面审查
每年（1小时）：系统优化
```

---

## 📅 日常维护（自动）

### 自动化任务

**1. 记忆提取**
```
触发时机：
- 用户说"记住..."
- 检测到重复模式（3次+）
- 会话结束前5分钟

执行内容：
- 扫描对话内容
- 提取关键信息
- 评估重要性
- 请求用户确认
```

**2. 评分更新**
```
触发时机：
- 记忆被访问
- 用户反馈
- 定期重算

执行内容：
- 更新访问频率
- 调整时效性分数
- 重新排序
```

**3. Git同步**
```
触发时机：
- 记忆更新后
- 定时（每30分钟）
- 手动触发

执行内容：
- 拉取远程更新
- 检测冲突
- 推送本地更改
```

### 监控指标

```bash
# 查看系统状态
cd ~/.adaptive-memory
bash scripts/status.sh

# 输出示例：
Total memories: 45
Average score: 6.8
Sync status: Up to date
Last backup: 2026-03-26 09:00
```

---

## 📆 每周维护（5分钟）

### 查看周总结

```bash
# 查看本周记忆变化
cat ~/.adaptive-memory/memory/weekly_summary.md
```

**检查清单**：
- [ ] 新增记忆是否准确
- [ ] 更新记忆是否合理
- [ ] 归档记忆是否正确
- [ ] 评分是否反映重要性

### 标记重要记忆

```markdown
# 在记忆中添加星标
## 重要的工作流程 ⭐
- TDD流程
- 代码审查清单
```

### 用户反馈

```
对于AI提取的建议：
- 准确：确认添加 ✅
- 不准确：修改后添加 ✏️
- 误判：标记为误判 ❌
```

---

## 🗓️ 每月维护（15分钟）

### 归档低分记忆

```bash
# 归档评分<4的记忆
bash scripts/archive-memory.sh --score <4

# 或手动归档
cd ~/.adaptive-memory/memory/preferences
# 将不重要的文件移到archive
mv old-preference.md ../../archive/2026/03/
```

### 合并重复记忆

```bash
# 查找重复记忆
bash scripts/find-duplicates.sh

# 手动合并
# 例如：两个关于TypeScript的记录
# 合并为一个，保留时间线
```

### 更新评分

```bash
# 重新计算所有评分
bash scripts/importance-score.sh --recalculate

# 查看评分变化
cat state/scores.json | jq '.memories[] | select(.score < 4)'
```

### 清理临时文件

```bash
# 删除临时文件
find ~/.adaptive-memory -name "*.tmp" -delete
find ~/.adaptive-memory -name "*.bak" -delete

# 清理Git
cd ~/.adaptive-memory
git gc --aggressive --prune=now
```

---

## 📋 每季维护（30分钟）

### 全面审查

```bash
# 运行审查脚本
bash scripts/audit-memory.sh

# 检查内容：
# - 记忆数量
# - 评分分布
# - 存储空间
# - 同步状态
```

### 优化分类

```markdown
# 检查分类是否合理
memory/
├── preferences/       # 偏好设置
│   ├── coding-style.md
│   ├── workflow.md
│   └── communication.md
├── decisions/         # 决策记录
├── patterns/          # 代码模式
└── debugging/         # 调试经验
```

### 更新文档

```bash
# 检查文档是否需要更新
# - README.md
# - QUICK_START.md
# - config/README.md

# 提交更新
git add docs/
git commit -m "docs: 更新文档"
```

### 性能优化

```bash
# 压缩Git仓库
git reflog expire --expire=now --all
git gc --aggressive --prune=now

# 优化数据库（如果使用）
# 重建索引
```

---

## 📊 每年维护（1小时）

### 系统评估

```
评估问题：
1. 系统是否满足需求？
2. 有哪些改进空间？
3. 是否需要升级技术栈？
4. 是否需要添加新功能？
```

### 数据分析

```bash
# 生成年度报告
bash scripts/yearly-report.sh

# 包含内容：
# - 新增记忆统计
# - 访问频率分析
# - 评分趋势
# - 同步成功率
```

### 归档历史

```bash
# 归档去年所有记忆
mkdir -p archive/2025
mv memory/archive/2025/* archive/2025/

# 创建年度总结
cat > archive/2025/README.md << EOF
# 2025年记忆总结

## 技术栈
- 主要语言：Python, TypeScript
- 框架：FastAPI, React
- 工具：Git, Docker

## 重要决策
- 2025-06：迁移到TypeScript
- 2025-09：采用TDD工作流
- 2025-12：引入CI/CD

## 统计
- 新增记忆：156条
- 归档记忆：43条
- 平均评分：6.8
EOF
```

### 系统升级

```bash
# 检查更新
cd ~/.adaptive-memory
git pull origin main

# 更新依赖（如果有）
# 升级脚本
# 更新配置
```

---

## 🔧 故障排查

### 问题1：同步失败

**症状**：
```bash
git push origin main
# ERROR: Connection refused
```

**诊断**：
```bash
# 1. 检查网络
ping github.com

# 2. 检查远程仓库
git remote -v

# 3. 检查认证
git config --get user.name
git config --get user.email
```

**解决**：
```bash
# 重新配置远程
git remote set-url origin https://github.com/575568329/memory.git

# 或使用SSH
git remote set-url origin git@github.com:575568329/memory.git
```

### 问题2：评分异常

**症状**：
```bash
# 重要记忆评分过低
# 或不重要记忆评分过高
```

**诊断**：
```bash
# 查看评分详情
cat state/scores.json | jq '.memories[] | select(.id == "memory_id")'

# 检查评分算法
bash scripts/importance-score.sh --debug
```

**解决**：
```bash
# 手动调整评分
vim state/scores.json

# 或重新计算
bash scripts/importance-score.sh --recalculate
```

### 问题3：文件损坏

**症状**：
```bash
# 文件无法读取
# 或格式错误
```

**诊断**：
```bash
# 检查文件
cat MEMORY.md

# 检查Git状态
git status
```

**解决**：
```bash
# 从Git恢复
git checkout HEAD -- MEMORY.md

# 或从备份恢复
cp backup/MEMORY.md.backup MEMORY.md
```

### 问题4：性能下降

**症状**：
```bash
# 加载缓慢
# 搜索卡顿
```

**诊断**：
```bash
# 检查文件数量
find memory/ -type f | wc -l

# 检查文件大小
du -sh memory/
```

**解决**：
```bash
# 归档旧记忆
bash scripts/archive-memory.sh --age 180

# 优化Git
git gc --aggressive

# 重建索引（如果使用）
```

---

## 📈 监控和报告

### 系统健康检查

```bash
#!/bin/bash
# health-check.sh

echo "=== 记忆系统健康检查 ==="

# 1. 检查文件完整性
echo -n "检查文件完整性... "
if [ -f MEMORY.md ] && [ -d memory/ ]; then
    echo "✅"
else
    echo "❌"
    exit 1
fi

# 2. 检查评分文件
echo -n "检查评分文件... "
if [ -f state/scores.json ]; then
    echo "✅"
else
    echo "❌"
fi

# 3. 检查Git状态
echo -n "检查Git状态... "
if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "✅"
else
    echo "❌"
fi

# 4. 检查同步状态
echo -n "检查同步状态... "
if git diff --quiet origin/main; then
    echo "✅"
else
    echo "⚠️  有未同步的更改"
fi

# 5. 统计信息
echo ""
echo "=== 统计信息 ==="
echo "记忆数量：$(find memory/ -type f | wc -l)"
echo "存储大小：$(du -sh . | cut -f1)"
echo "最后同步：$(git log -1 --format='%ci')"
```

### 性能指标

```bash
# 生成性能报告
bash scripts/performance-report.sh

# 输出示例：
Memory count: 45
Average score: 6.8
Storage size: 2.3M
Load time: 0.8s
Sync success rate: 98%
```

### 趋势分析

```bash
# 分析记忆增长趋势
git log --since="3 months ago" --oneline | wc -l

# 分析评分分布
cat state/scores.json | jq '.memories | group_by(.score_range) | map({score: .[0].score_range, count: length})'
```

---

## 🔄 备份和恢复

### 自动备份

```bash
#!/bin/bash
# backup.sh

BACKUP_DIR="$HOME/memory-backup/$(date '+%Y%m%d_%H%M%S')"
mkdir -p "$BACKUP_DIR"

# 备份记忆文件
cp -r ~/.adaptive-memory "$BACKUP_DIR/"

# 备份配置
cp ~/.claude/CLAUDE.md "$BACKUP_DIR/"
cp -r ~/.claude/skills/memory-manager "$BACKUP_DIR/"

# 压缩备份
tar -czf "$BACKUP_DIR.tar.gz" "$BACKUP_DIR"
rm -rf "$BACKUP_DIR"

echo "✅ 备份完成：$BACKUP_DIR.tar.gz"
```

### 定期备份

```bash
# 添加到crontab
# 每天凌晨2点备份
0 2 * * * /path/to/backup.sh
```

### 恢复流程

```bash
# 1. 解压备份
tar -xzf memory-backup/20260326_020000.tar.gz

# 2. 恢复文件
cp -r 20260326_020000/.adaptive-memory/* ~/.adaptive-memory/
cp 20260326_020000/CLAUDE.md ~/.claude/
cp -r 20260326_020000/memory-manager ~/.claude/skills/

# 3. 验证恢复
bash config/setup.sh
```

---

## 📝 维护检查清单

### 每周检查清单

- [ ] 查看周总结
- [ ] 验证新记忆准确性
- [ ] 标记重要记忆
- [ ] 提供用户反馈

### 每月检查清单

- [ ] 归档低分记忆（<4分）
- [ ] 合并重复记忆
- [ ] 更新评分
- [ ] 清理临时文件
- [ ] 检查同步状态

### 每季检查清单

- [ ] 全面审查系统
- [ ] 优化分类结构
- [ ] 更新文档
- [ ] 性能优化
- [ ] 安全检查

### 每年检查清单

- [ ] 系统评估
- [ ] 数据分析
- [ ] 归档历史
- [ ] 系统升级
- [ ] 备份验证

---

## 🎯 维护目标

### 数量控制

```
MEMORY.md：<200行
核心记忆：<50条
总记忆数：<1000条
存储空间：<100MB
```

### 质量标准

```
准确率：>90%
重要记忆识别率：>85%
用户满意度：>80%
同步成功率：>95%
```

### 性能目标

```
加载时间：<1秒
搜索时间：<0.5秒
同步时间：<5秒
响应时间：<2秒
```

---

## 📚 相关资源

### 脚本工具
- `scripts/health-check.sh` - 健康检查
- `scripts/backup.sh` - 备份工具
- `scripts/archive-memory.sh` - 归档工具
- `scripts/performance-report.sh` - 性能报告

### 文档
- [最佳实践](./BEST_PRACTICES.md)
- [常见问题](./FAQ.md)
- [快速开始](../QUICK_START.md)

---

**最后更新**：2026-03-26
**维护者**：记忆管理器
