#!/bin/bash
# Claude Code 配置自动初始化脚本
# 用途：在新设备上快速设置配置文件

set -euo pipefail

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
MEMORY_DIR="$(dirname "$SCRIPT_DIR")"

echo "=================================="
echo "  Claude Code 配置初始化"
echo "=================================="
echo ""

# 检查是否在正确的目录
if [ ! -f "$MEMORY_DIR/MEMORY.md" ]; then
    echo -e "${RED}❌ 错误：未找到 MEMORY.md${NC}"
    echo "请确保在记忆库根目录运行此脚本"
    exit 1
fi

echo -e "${YELLOW}📁 记忆库位置：$MEMORY_DIR${NC}"
echo ""

# 1. 备份现有配置
echo -e "${YELLOW}📦 步骤1：备份现有配置${NC}"

CLAUDE_DIR="$HOME/.claude"
BACKUP_DIR="$MEMORY_DIR/config/backup/$(date '+%Y%m%d_%H%M%S')"

mkdir -p "$BACKUP_DIR"

if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    cp "$CLAUDE_DIR/CLAUDE.md" "$BACKUP_DIR/CLAUDE.md.backup"
    echo -e "${GREEN}✅ 已备份 CLAUDE.md${NC}"
fi

if [ -d "$CLAUDE_DIR/skills/memory-manager" ]; then
    cp -r "$CLAUDE_DIR/skills/memory-manager" "$BACKUP_DIR/"
    echo -e "${GREEN}✅ 已备份 memory-manager skill${NC}"
fi

echo ""

# 2. 复制配置文件
echo -e "${YELLOW}📋 步骤2：复制配置文件${NC}"

# 复制 CLAUDE.md
if [ -f "$SCRIPT_DIR/CLAUDE.md" ]; then
    cp "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    echo -e "${GREEN}✅ CLAUDE.md 已复制${NC}"
else
    echo -e "${RED}❌ 未找到 config/CLAUDE.md${NC}"
    exit 1
fi

# 复制 skill
if [ -d "$SCRIPT_DIR/skills/memory-manager" ]; then
    mkdir -p "$CLAUDE_DIR/skills"
    cp -r "$SCRIPT_DIR/skills/memory-manager" "$CLAUDE_DIR/skills/"
    echo -e "${GREEN}✅ memory-manager skill 已复制${NC}"
else
    echo -e "${RED}❌ 未找到 config/skills/memory-manager${NC}"
    exit 1
fi

echo ""

# 3. 设置权限
echo -e "${YELLOW}🔐 步骤3：设置文件权限${NC}"

chmod 644 "$CLAUDE_DIR/CLAUDE.md"
chmod 644 "$CLAUDE_DIR/skills/memory-manager/skill.md"
echo -e "${GREEN}✅ 文件权限已设置${NC}"

echo ""

# 4. 验证配置
echo -e "${YELLOW}🔍 步骤4：验证配置${NC}"

# 检查 CLAUDE.md
if [ -f "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo -e "${GREEN}✅ CLAUDE.md 存在${NC}"

    # 检查是否包含记忆系统配置
    if grep -q "记忆系统集成" "$CLAUDE_DIR/CLAUDE.md"; then
        echo -e "${GREEN}✅ CLAUDE.md 包含记忆系统配置${NC}"
    else
        echo -e "${YELLOW}⚠️  警告：CLAUDE.md 可能不是最新版本${NC}"
    fi
else
    echo -e "${RED}❌ CLAUDE.md 不存在${NC}"
    exit 1
fi

# 检查 skill
if [ -f "$CLAUDE_DIR/skills/memory-manager/skill.md" ]; then
    echo -e "${GREEN}✅ memory-manager skill 存在${NC}"

    # 检查 skill 格式
    if head -1 "$CLAUDE_DIR/skills/memory-manager/skill.md" | grep -q "---"; then
        echo -e "${GREEN}✅ skill 格式正确${NC}"
    else
        echo -e "${YELLOW}⚠️  警告：skill 格式可能不正确${NC}"
    fi
else
    echo -e "${RED}❌ memory-manager skill 不存在${NC}"
    exit 1
fi

echo ""

# 5. 创建符号链接（可选）
echo -e "${YELLOW}🔗 步骤5：符号链接设置（可选）${NC}"

read -p "是否创建符号链接到配置文件？(y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # 删除现有文件
    rm -f "$CLAUDE_DIR/CLAUDE.md"
    rm -rf "$CLAUDE_DIR/skills/memory-manager"

    # 创建符号链接
    ln -s "$SCRIPT_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
    ln -s "$SCRIPT_DIR/skills/memory-manager" "$CLAUDE_DIR/skills/memory-manager"

    echo -e "${GREEN}✅ 符号链接已创建${NC}"
    echo -e "${YELLOW}⚠️  注意：修改会直接同步到 Git 仓库${NC}"
else
    echo -e "${YELLOW}⏭️  跳过符号链接创建${NC}"
fi

echo ""

# 6. 完成
echo "=================================="
echo -e "${GREEN}✅ 配置初始化完成！${NC}"
echo "=================================="
echo ""
echo "📝 配置文件位置："
echo "   - CLAUDE.md: $CLAUDE_DIR/CLAUDE.md"
echo "   - memory-manager: $CLAUDE_DIR/skills/memory-manager/"
echo ""
echo "📦 备份位置：$BACKUP_DIR"
echo ""
echo "🔄 下一步："
echo "   1. 重启 Claude Code"
echo "   2. 检查 skill 是否被识别"
echo "   3. 测试记忆系统：说 \"记住...\""
echo ""
echo "📚 更多信息："
echo "   查看 $SCRIPT_DIR/README.md"
echo ""
