---
name: memory-manager
description: 管理自适应记忆层。触发条件：(1) 用户说"记住"、"记录"、"添加到记忆" (2) AI 检测到重复模式（3次+）(3) 会话结束时自动提取 (4) 每周日晚上8点周总结
version: 1.0.0
---

# 记忆管理器 (Memory Manager)

## 技能概述

管理跨设备自适应记忆层，实现个人偏好、决策记录和知识模式的自动化提取、评分和同步。

## 记忆库架构

```
┌─────────────────────────────────────────────────────────┐
│                    应用层                              │
│  Claude Code会话 → AI提取 → 用户确认 → 记忆更新       │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                  记忆管理层                            │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │ 工作记忆层   │  │ 长期记忆层   │  │ 归档存储层   │  │
│  │ (会话临时)  │→ │ (核心偏好)  │→ │ (历史记录)  │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└─────────────────────────────────────────────────────────┘
                          ↓
┌─────────────────────────────────────────────────────────┐
│                   存储层                               │
│  GitHub: https://github.com/575568329/memory          │
│  本地:  C:\Users\fjyu9\.adaptive-memory\               │
└─────────────────────────────────────────────────────────┘
```

## 触发条件

### 1. 显式触发（用户明确要求）

用户说以下关键词时触发：
- "记住我的偏好"
- "记录这个决策"
- "添加到记忆"
- "更新记忆库"
- "保存这个"

**示例对话**：
```
用户: "记住，我写代码时总是先写测试"
→ 触发 memory-manager，提取工作流程偏好
```

### 2. 隐式触发（AI 自动检测）

**检测条件**（满足任一即触发）：
- 用户在 3 次以上对话中提到同一习惯
- 检测到明确的技术栈选择决策
- 发现用户重复的工作流程模式
- 遇到用户反复遇到的错误和解决方案

**示例场景**：
```python
# 检测到重复模式
pattern_occurrences = count_occurrences(current_session)
if pattern_occurrences >= 3:
    trigger_memory_manager()
```

### 3. 定时触发

- **会话结束前 5 分钟**：自动提取关键信息
- **每周日晚上 8 点**：自动运行周总结

## 工作流程

### Step 1: 扫描当前会话

扫描当前会话，查找以下信息：

```python
def scan_current_session():
    """扫描当前会话提取关键信息"""

    findings = {
        'preferences': [],      # 用户偏好
        'decisions': [],        # 决策记录
        'patterns': [],         # 行为模式
        'technical': [],        # 技术栈信息
        'frustrations': []      # 痛点和解决方案
    }

    # 扫描用户明确偏好表述
    preferences = extract_explicit_preferences([
        "我喜欢", "我通常", "我偏好",
        "总是", "从不", "习惯"
    ])

    # 扫描技术栈选择
    decisions = extract_technical_decisions([
        "选择", "决定使用", "采用",
        "vs", "而不是", "替代"
    ])

    # 扫描重复模式
    patterns = find_repeated_patterns(min_occurrences=3)

    # 扫描错误和解决方案
    solutions = extract_solutions_and_fixes()

    return findings
```

### Step 2: 验证和评分

```python
def validate_and_score(extracted_items):
    """验证并评分提取的信息"""

    for item in extracted_items:
        # 1. 检查是否已存在
        if exists_in_memory(item):
            update_access_count(item)
            continue

        # 2. 评估重要性（1-10分）
        score = calculate_importance_score(item)

        # 3. 计算置信度（0-100%）
        confidence = calculate_confidence(item)

        # 4. 决定是否建议添加
        if score >= 7 or confidence >= 0.8:
            add_to_suggestions(item, score, confidence)
```

#### 重要性评分算法

```python
def calculate_importance_score(memory_item):
    """计算记忆重要性评分"""

    # 访问频率（带时间衰减）
    freq_score = sum(
        1.0 / ((days_since_access + 1) ** 0.5)
        for access in access_history
    )

    # 时效性（Sigmoid 函数）
    days_since_update = (now - memory_item.created).days
    recency_score = 1.0 / (1.0 + math.exp((days_since_update - 30) / 10))

    # 用户确认（直接使用）
    user_score = memory_item.user_rating * 2  # 1-5星 -> 2-10分

    # 上下文相关性
    context_score = calculate_context_similarity(memory_item, current_context)

    # 加权总分
    total_score = (
        freq_score * 0.3 +
        recency_score * 0.3 +
        user_score * 0.3 +
        context_score * 0.1
    )

    return {
        'total': total_score,
        'breakdown': {
            'frequency': freq_score,
            'recency': recency_score,
            'user_rating': user_score,
            'context': context_score
        }
    }
```

### Step 3: 用户确认（关键步骤）

使用 `AskUserQuestion` 工具展示建议：

```markdown
🤖 检测到新的用户偏好

**类型**：编码风格
**置信度**：85%
**证据**：见于 2026-03-20, 03-23, 03-25 的对话

**检测到的内容**：
> 用户在3次对话中明确提到"先写测试再实现"，并严格遵循TDD流程

**AI 分析**：
- 这是一个稳定的编码习惯
- 符合测试驱动开发（TDD）最佳实践
- 建议归类到工作流程偏好

**建议记录位置**：`memory/preferences/workflow.md`

**重要性评分**：8.5/10（高频率 + 高一致性）

**操作选项**：
- [x] **确认添加** - 按建议添加到记忆库
- [ ] **修改后添加** - 我要调整内容或位置
- [ ] **忽略** - 这次不记录
- [ ] **标记为误判** - 帮助改进AI提取

---
*AI置信度：85% | 基于最近3次对话 | 评分：8.5/10*
```

### Step 4: 更新记忆

```python
def update_memory(user_choice, item):
    """根据用户选择更新记忆"""

    if user_choice == "确认添加":
        # 1. 写入对应文件
        write_to_memory(item)

        # 2. 更新 MEMORY.md（如果重要性≥7）
        if item.score >= 7:
            update_core_memory(item)

        # 3. 更新评分
        update_importance_score(item)

        # 4. 触发同步
        trigger_git_sync()

        log_success_pattern(item)

    elif user_choice == "修改后添加":
        # 收集修改内容
        modified = collect_user_modifications()
        write_to_memory(modified)
        log_user_preference()

    elif user_choice == "忽略":
        log_ignore_reason()
        # 降低下次检测的优先级

    elif user_choice == "标记为误判":
        log_false_positive()
        # 用于改进提取算法
```

## 记忆存储结构

### 文件组织

```
~/.adaptive-memory/
├── MEMORY.md                    # 核心记忆（<200行，自动加载）
├── memory/
│   ├── preferences/
│   │   ├── coding-style.md      # 编码风格
│   │   ├── workflow.md          # 工作流程
│   │   └── communication.md     # 沟通偏好
│   ├── decisions/
│   │   └── YYYYMMDDHHMMSS_标题.md  # 决策记录
│   ├── patterns.md              # 代码模式
│   ├── debugging.md             # 调试经验
│   ├── projects/                # 项目上下文
│   └── archive/                 # 归档存储
└── state/
    ├── scores.json              # 重要性评分
    └── conflicts.json           # 冲突记录
```

### 记忆分类

| 分类 | 文件路径 | 示例内容 |
|------|---------|---------|
| **编码风格** | `memory/preferences/coding-style.md` | 语言选择、命名规范、代码组织 |
| **工作流程** | `memory/preferences/workflow.md` | TDD、代码审查、调试习惯 |
| **沟通偏好** | `memory/preferences/communication.md` | 语言、风格、反馈方式 |
| **决策记录** | `memory/decisions/YYYYMMDDHHMMSS_*.md` | 技术选型、架构决策 |
| **代码模式** | `memory/patterns.md` | 常用模式、反模式 |
| **调试经验** | `memory/debugging.md` | 问题诊断、解决方案 |

## Git 自动同步

### 同步触发时机

1. 更新记忆后立即同步
2. 每30分钟自动同步
3. 会话结束时同步

### 同步脚本

```bash
#!/bin/bash
# ~/.adaptive-memory/scripts/sync-memory.sh

MEMORY_DIR="${MEMORY_DIR:-$HOME/.adaptive-memory}"
cd "$MEMORY_DIR"

# 拉取远程更新
git pull origin main --no-edit

# 检测冲突
if git diff --name-only --diff-filter=U | grep -q .; then
    echo "⚠️  检测到冲突，启动解决流程..."
    ./scripts/resolve-conflicts.sh
fi

# 推送本地更新
git add .
git commit -m "feat: 添加/更新记忆 $(date '+%Y-%m-%d %H:%M:%S')" || true
git push origin main

echo "✅ 记忆已同步到远程仓库"
```

### 冲突处理

```python
def resolve_conflicts():
    """处理多设备同步冲突"""

    conflicts = detect_conflicts()

    for conflict in conflicts:
        conflict_type = classify_conflict(conflict)

        if conflict_type == "演化":
            # 技术栈/偏好正常演进
            archive_old_version()
            keep_new_version()
            add_evolution_note()

        elif conflict_type == "矛盾":
            # 真实冲突，需要用户选择
            present_conflict_resolution_options()

        elif conflict_type == "互补":
            # 信息互补，自动合并
            merge_versions()
```

## 使用示例

### 示例1：记录编码偏好

```
用户: "记住，我写TypeScript时从不使用any类型"
```

**AI 执行**：
1. 触发 memory-manager
2. 提取：编码风格偏好，TypeScript，禁用 any
3. 评分：8/10（明确表述 + 重复提及）
4. 请求确认
5. 写入 `memory/preferences/coding-style.md`
6. 同步到 GitHub

### 示例2：检测技术栈决策

```
对话历史：
2026-03-20: "我选择pnpm而不是npm"
2026-03-23: "在这个项目也用pnpm"
2026-03-25: "pnpm确实比npm快"
```

**AI 执行**：
1. 检测到重复模式（3次）
2. 提取：包管理器偏好，pnpm > npm
3. 评分：9/10（高频 + 一致）
4. 请求确认
5. 写入决策记录
6. 更新 MEMORY.md

### 示例3：周总结

```markdown
# 本周记忆总结 (2026-03-25)

## 📊 统计数据
- 新增记忆：12条
- 更新记忆：5条
- 归档记忆：3条

## 🆕 新发现的偏好
1. 用户在处理复杂任务前喜欢先画流程图
2. 开始关注WebAssembly技术
3. 偏好使用pnpm而非npm

## 📝 决策记录
- 2026-03-23：选择pnpm作为包管理器

## 💡 建议操作
- [ ] 将"流程图偏好"加入workflow.md
- [ ] 更新技术栈列表
```

## 安全注意事项

### 禁止提交的内容

**敏感信息检测**：
```python
SENSITIVE_PATTERNS = [
    r'api[_-]?key\s*[=:]\s*\S',
    r'password\s*[=:]\s*\S',
    r'secret\s*[=:]\s*\S',
    r'token\s*[=:]\s*\S',
    r'credential',
]

def check_sensitive_info(content):
    """检测敏感信息"""
    for pattern in SENSITIVE_PATTERNS:
        if re.search(pattern, content, re.IGNORECASE):
            raise SecurityError("检测到敏感信息！")
```

**如果检测到敏感信息**：
1. 立即停止提交
2. 通知用户手动处理
3. 记录到安全日志
4. 建议使用 git-secrets 预防

## 常见问题

### Q1: 如何避免记忆膨胀？

**A**: 多重保护机制：
- 重要性评分自动淘汰低分内容（<4分）
- 定期归档旧记录（>6个月）
- MEMORY.md 严格控制在200行以内
- 相似记忆自动合并

### Q2: AI 提取不准确怎么办？

**A**: 反馈循环机制：
```python
if user_mark_false_positive:
    log_false_positive(item)
    decrease_confidence(pattern)
    retrain_extraction_model()
```

### Q3: 多设备同时编辑如何处理？

**A**: 完善的冲突处理：
- Git 自动检测冲突
- 冲突解决脚本辅助
- 提供三种解决方案：
  - 保留最新版本
  - 合并两个版本
  - 手动解决冲突

## 性能指标

| 指标 | 目标值 | 说明 |
|------|--------|------|
| MEMORY.md 行数 | <200行 | 核心记忆精简 |
| 加载时间 | <1秒 | 会话启动时 |
| 同步时间 | <5秒 | Git 推送/拉取 |
| AI 提取准确率 | >80% | 用户确认比例 |
| 误判率 | <10% | 标记为误判比例 |

## 更新日志

### v1.0.0 (2026-03-26)
- ✅ 初始版本
- ✅ 支持显式/隐式/定时触发
- ✅ 重要性评分算法
- ✅ Git 自动同步
- ✅ 冲突检测和解决
- ✅ 安全检查机制

## 相关文件

- **方案文档**：`C:\Users\fjyu9\Desktop\跨设备自适应记忆层设计方案.md`
- **GitHub 仓库**：https://github.com/575568329/memory
- **CLAUDE.md 配置**：`C:\Users\fjyu9\.claude\CLAUDE.md`（第八章）

---

**最后更新**：2026-03-26
**维护者**：Claude Code + 用户协作
