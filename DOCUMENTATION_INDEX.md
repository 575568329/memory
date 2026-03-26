# 文档索引

> 完整的文档导航和快速查找

---

## 📚 文档分类

### 🚀 快速入门

| 文档 | 描述 | 适用对象 |
|------|------|----------|
| [README.md](README.md) | 项目主页和介绍 | 所有人 |
| [QUICK_START.md](QUICK_START.md) | 三步快速部署 | 新用户 |
| [TEST_REPORT.md](TEST_REPORT.md) | 功能测试报告 | 验证者 |

### 📖 使用指南

| 文档 | 描述 | 适用场景 |
|------|------|----------|
| [BEST_PRACTICES.md](docs/BEST_PRACTICES.md) | 最佳实践指南 | 学习高效使用 |
| [FAQ.md](docs/FAQ.md) | 25个常见问题 | 解决疑问 |

### ⚙️ 配置管理

| 文档 | 描述 | 适用场景 |
|------|------|----------|
| [config/README.md](config/README.md) | 配置文件说明 | 理解配置 |
| [config/setup.sh](config/setup.sh) | 自动初始化脚本 | 新设备设置 |

### 🔧 维护管理

| 文档 | 描述 | 适用场景 |
|------|------|----------|
| [MAINTENANCE.md](docs/MAINTENANCE.md) | 维护指南 | 系统维护 |

### 📋 设计文档

| 文档 | 描述 | 适用对象 |
|------|------|----------|
| [设计方案.md](../跨设备自适应记忆层设计方案.md) | 完整设计文档 | 架构师 |

---

## 🎯 按使用场景查找

### 场景1：我是新用户

**阅读顺序**：
1. [README.md](README.md) - 了解项目
2. [QUICK_START.md](QUICK_START.md) - 快速部署
3. [FAQ.md](docs/FAQ.md#基础问题) - 基础问题

### 场景2：我想高效使用

**阅读顺序**：
1. [BEST_PRACTICES.md](docs/BEST_PRACTICES.md) - 最佳实践
2. [FAQ.md](docs/FAQ.md#使用问题) - 使用技巧
3. [MAINTENANCE.md](docs/MAINTENANCE.md) - 日常维护

### 场景3：我要配置新设备

**操作步骤**：
1. [QUICK_START.md](QUICK_START.md#新设备设置) - 快速开始
2. 运行 `bash config/setup.sh` - 自动配置
3. [FAQ.md](docs/FAQ.md#q9-多设备如何保持同步) - 多设备同步

### 场景4：遇到问题

**查找顺序**：
1. [FAQ.md](docs/FAQ.md) - 常见问题解答
2. [MAINTENANCE.md](docs/MAINTENANCE.md#故障排查) - 故障排查
3. [GitHub Issues](https://github.com/575568329/memory/issues) - 报告问题

### 场景5：我想贡献

**阅读顺序**：
1. [README.md](README.md#贡献) - 贡献指南
2. [设计方案.md](../跨设备自适应记忆层设计方案.md) - 理解架构
3. GitHub Discussions - 讨论想法

---

## 🔍 按关键词查找

### 关键词索引

**A**
- Archive（归档）: [BEST_PRACTICES.md](docs/BEST_PRACTICES.md#记忆归档)
- Auto-sync（自动同步）: [FAQ.md](docs/FAQ.md#q9-多设备如何保持同步)

**C**
- Configuration（配置）: [config/README.md](config/README.md)
- Conflict（冲突）: [FAQ.md](docs/FAQ.md#q10-如果同时编辑会冲突吗)
- Contributing（贡献）: [README.md](README.md#贡献)

**D**
- Deployment（部署）: [QUICK_START.md](QUICK_START.md)
- Debugging（调试）: [MAINTENANCE.md](docs/MAINTENANCE.md#故障排查)

**F**
- FAQ（常见问题）: [FAQ.md](docs/FAQ.md)

**M**
- Maintenance（维护）: [MAINTENANCE.md](docs/MAINTENANCE.md)
- Memory types（记忆类型）: [BEST_PRACTICES.md](docs/BEST_PRACTICES.md#分层存储)

**P**
- Performance（性能）: [README.md](README.md#性能指标)
- Privacy（隐私）: [FAQ.md](docs/FAQ.md#q13-我的隐私安全吗)

**S**
- Scoring（评分）: [BEST_PRACTICES.md](docs/BEST_PRACTICES.md#评分指南)
- Security（安全）: [FAQ.md](docs/FAQ.md#安全)
- Setup（设置）: [QUICK_START.md](QUICK_START.md)

**T**
- Troubleshooting（故障排查）: [MAINTENANCE.md](docs/MAINTENANCE.md#故障排查)

---

## 📊 文档统计

| 类型 | 数量 | 总行数 |
|------|------|--------|
| 主文档 | 4 | ~500行 |
| 指南文档 | 3 | ~1700行 |
| 配置文档 | 2 | ~300行 |
| 设计文档 | 1 | ~900行 |
| **总计** | **10** | **~3400行** |

---

## 🔄 文档更新

### 最近更新

- **2026-03-26**: 创建完整文档体系
  - ✅ 主文档 (README, QUICK_START)
  - ✅ 指南文档 (BEST_PRACTICES, FAQ, MAINTENANCE)
  - ✅ 配置文档 (config/README, setup.sh)
  - ✅ 测试文档 (TEST_REPORT)

### 更新计划

- [ ] 添加视频教程
- [ ] 添加互动示例
- [ ] 多语言支持
- [ ] API 文档

---

## 💡 文档使用技巧

### 技巧1：搜索关键词

```bash
# 在所有文档中搜索关键词
cd ~/.adaptive-memory
grep -r "关键词" docs/

# 搜索特定文件
grep "关键词" README.md
```

### 技巧2：生成目录

```bash
# 使用tree命令
tree -L 2

# 或使用find
find . -name "*.md" | sort
```

### 技巧3：导出PDF

```bash
# 使用pandoc导出
pandoc README.md -o README.pdf
```

---

## 📞 获取帮助

### 文档无法解决

1. 查看 [GitHub Issues](https://github.com/575568329/memory/issues)
2. 搜索 [GitHub Discussions](https://github.com/575568329/memory/discussions)
3. 创建新的 Issue

### 文档改进

欢迎改进文档！

```bash
# 1. Fork 仓库
# 2. 编辑文档
# 3. 提交 Pull Request
```

---

**最后更新**：2026-03-26
**维护者**：记忆管理器
