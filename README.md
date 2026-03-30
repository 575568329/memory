# 跨设备自适应记忆层

> 智能化个人记忆管理系统 - 让 AI 记住你的偏好和决策

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](CHANGELOG.md)
[![Claude Code](https://img.shields.io/badge/Claude_Code-compatible-brightgreen.svg)](https://docs.anthropic.com/)

---

## ✨ 特性

- ✅ **跨设备同步** - GitHub 私有仓库实现多设备访问
- ✅ **半自动维护** - AI 辅助提取，用户审核确认
- ✅ **智能化管理** - 自动评分、冲突检测、定期总结
- ✅ **精简高效** - 不占用过多上下文，持续优化

---

## 🚀 快速开始

### 三步部署

```bash
# 1. 克隆仓库
git clone https://github.com/575568329/memory.git ~/.adaptive-memory

# 2. 运行初始化
cd ~/.adaptive-memory
bash config/setup.sh

# 3. 重启 Claude Code
```

### 验证安装

在 Claude Code 中说：
```
记住，我偏好使用 TypeScript 而不是 JavaScript
```

如果看到 AI 自动提取记忆并请求确认，说明安装成功！

---

## 📖 文档导航

### 新手入门
1. **[快速开始指南](QUICK_START.md)** - 三步快速部署
2. **[常见问题解答](docs/FAQ.md)** - 25个常见问题

### 使用指南
3. **[最佳实践](docs/BEST_PRACTICES.md)** - 高效使用记忆系统
4. **[配置说明](config/README.md)** - 配置文件详解

### 维护管理
5. **[维护指南](docs/MAINTENANCE.md)** - 保持系统健康
6. **[测试报告](TEST_REPORT.md)** - 功能验证报告

### 方案文档
7. **[设计方案](../跨设备自适应记忆层设计方案.md)** - 完整设计文档

---

## 💡 使用示例

### 示例1：记录编码偏好

```
你: "记住，我写代码时总是先写测试"
```

**AI 自动**：
1. 检测到 TDD 工作流偏好
2. 评分：8.5/10（高重要性）
3. 请求确认
4. 写入 `memory/preferences/workflow.md`
5. 同步到 GitHub

### 示例2：技术决策记录

```
对话历史显示你3次选择 pnpm 而不是 npm
```

**AI 自动**：
1. 识别重复模式
2. 提取：包管理器偏好
3. 创建决策记录
4. 归档到 `memory/decisions/`

### 示例3：跨设备同步

```
设备A: 添加新记忆
   ↓
自动推送到 GitHub
   ↓
设备B: 自动拉取更新
   ↓
重启 Claude Code
   ↓
记忆已同步 ✅
```

---

## 📁 文件结构

```
~/.adaptive-memory/
├── README.md                  # 本文件
├── MEMORY.md                  # 核心记忆（<200行）
├── QUICK_START.md             # 快速开始
├── config/                    # 配置文件
│   ├── CLAUDE.md             # Claude Code 配置
│   ├── README.md             # 配置说明
│   ├── setup.sh              # 初始化脚本
│   └── skills/               # 技能定义
│       └── memory-manager/
│           └── skill.md
├── docs/                      # 文档
│   ├── BEST_PRACTICES.md     # 最佳实践
│   ├── FAQ.md                # 常见问题
│   └── MAINTENANCE.md        # 维护指南
├── memory/                    # 记忆存储
│   ├── preferences/          # 偏好设置
│   ├── decisions/            # 决策记录
│   ├── patterns/             # 代码模式
│   ├── debugging/            # 调试经验
│   └── archive/              # 归档存储
├── state/                     # 状态追踪
│   └── scores.json           # 评分记录
└── .git/                      # Git 仓库
```

---

## 🎯 核心概念

### 三层记忆架构

```
工作记忆层（会话临时）
    ↓ 自动评估
长期记忆层（核心偏好）
    ↓ 定期总结
归档存储层（历史记录）
```

### 重要性评分

```python
score = (
    frequency * 0.3 +      # 访问频率
    recency * 0.3 +        # 时效性
    user_rating * 0.3 +    # 用户评分
    context * 0.1          # 上下文相关
)
```

**评分分布**：
- **9-10分**：核心记忆 → MEMORY.md
- **7-8分**：重要记忆 → MEMORY.md + 分类
- **5-6分**：中期记忆 → 分类文件
- **<4分**：低分记忆 → 归档或删除

---

## 🔄 使用流程

### 日常使用

```
1. 正常使用 Claude Code
   ↓
2. AI 检测到记忆触发
   ↓
3. 展示提取建议
   ↓
4. 用户确认
   ↓
5. 自动写入文件
   ↓
6. Git 自动同步
```

### 新设备设置

```bash
# 1. 克隆仓库
git clone https://github.com/575568329/memory.git ~/.adaptive-memory

# 2. 运行初始化
bash config/setup.sh

# 3. 重启 Claude Code
```

详见：[快速开始指南](QUICK_START.md)

---

## 🛡️ 安全性

### 隐私保护

- ✅ **私有仓库** - 仅你可见
- ✅ **敏感信息过滤** - 自动检测 API 密钥、密码
- ✅ **用户确认** - 所有记录需确认
- ✅ **手动审查** - 可随时编辑和删除

### 禁止记录

- ❌ API 密钥和密码
- ❌ 个人身份信息
- ❌ 银行账号和信用卡
- ❌ 临时凭证和 token

详见：[常见问题 - 安全性](docs/FAQ.md#安全)

---

## 📊 性能指标

| 指标 | 目标值 | 实际值 | 状态 |
|------|--------|--------|------|
| MEMORY.md 行数 | <200行 | 45行 | ✅ |
| 加载时间 | <1秒 | ~0.8秒 | ✅ |
| 同步时间 | <5秒 | ~2秒 | ✅ |
| 内存占用 | <10MB | ~2MB | ✅ |
| 仓库大小 | <100MB | ~270KB | ✅ |

---

## 🔧 系统要求

### 必需项

- **Git** - 版本控制
- **Claude Code** - AI 编程助手
- **GitHub 账号** - 远程仓库
- **Bash** - 命令行工具

### 可选项

- **多台设备** - 单设备也可使用
- **定时任务** - 自动同步（可选）

### 支持平台

- ✅ Windows 10/11（Git Bash）
- ✅ macOS（原生 Bash）
- ✅ Linux（原生 Bash）

---

## 🚧 故障排查

### 常见问题

**Q: Skill 没有被识别？**

A: 运行重新配置：
```bash
cd ~/.adaptive-memory
bash config/setup.sh
```

**Q: 同步失败？**

A: 检查网络连接：
```bash
ping github.com
git remote -v
```

**Q: 配置未生效？**

A: 重启 Claude Code

详见：[常见问题解答](docs/FAQ.md)

---

## 📈 路线图

### v1.0（当前版本）
- ✅ 基础记忆提取和评分
- ✅ 跨设备配置同步
- ✅ 冲突检测和解决
- ✅ 完整文档体系

### v1.1（计划中）
- [ ] 语义检索（向量数据库）
- [ ] Web UI 管理界面
- [ ] 自动化脚本完善
- [ ] 性能优化

### v2.0（未来）
- [ ] 多模态记忆（图片、截图）
- [ ] 团队协作记忆
- [ ] AI 驱动的自动总结
- [ ] 移动端访问

---

## 🤝 贡献

欢迎贡献！

### 报告问题

[GitHub Issues](https://github.com/575568329/memory/issues)

### 提交改进

```bash
# 1. Fork 仓库
# 2. 创建分支
git checkout -b feature/new-feature

# 3. 提交更改
git commit -m "feat: 添加新功能"

# 4. 推送并创建 PR
git push origin feature/new-feature
```

---

## 📄 许可证

MIT License - 详见 [LICENSE](LICENSE)

---

## 🙏 致谢

- [Claude Code](https://docs.anthropic.com/) - AI 编程助手
- [Mem0](https://mem0.ai/) - AI Memory Layer 灵感
- [Zep](https://www.zep.ai/) - 长期记忆参考
- [AdaMem](https://arxiv.org/) - 记忆架构参考

---

## 📞 联系方式

- **GitHub**: [575568329/memory](https://github.com/575568329/memory)
- **Issues**: [问题追踪](https://github.com/575568329/memory/issues)
- **Discussions**: [讨论区](https://github.com/575568329/memory/discussions)

---

## 🎉 开始使用

准备就绪？让我们开始吧！

```bash
git clone https://github.com/575568329/memory.git ~/.adaptive-memory
cd ~/.adaptive-memory
bash config/setup.sh
```

**5分钟后，你将拥有一个智能化的个人记忆系统！** 🚀

---

**最后更新**：2026-03-26
**版本**：v1.0.0
**维护者**：记忆管理器
# test hook
# hook test 2
