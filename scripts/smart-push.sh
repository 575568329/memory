#!/bin/bash
# 智能推送脚本 - 根据更改重要性决定推送策略

set -euo pipefail

MEMORY_DIR="${MEMORY_DIR:-$HOME/.adaptive-memory}"
cd "$MEMORY_DIR"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}=== 智能记忆同步 ===${NC}"
echo ""

# 检查网络连接
if ! ping -c 1 github.com &> /dev/null; then
    echo -e "${YELLOW}⚠️  网络不可用，加入推送队列${NC}"
    echo "$(date '+%Y-%m-%d %H:%M:%S')" >> .push_queue
    exit 0
fi

# 检查是否有未推送的提交
UNPUSHED=$(git log origin/main..HEAD --oneline | wc -l)
if [ "$UNPUSHED" -eq 0 ]; then
    echo -e "${GREEN}✅ 没有需要推送的更改${NC}"
    exit 0
fi

echo -e "${BLUE}📊 检测到 $UNPUSHED 个未推送的提交${NC}"
echo ""

# 分析更改的重要性
PUSH_REASON=""
PRIORITY="normal"

# 检查是否修改了核心记忆
if git diff origin/main..HEAD --name-only | grep -q "MEMORY.md"; then
    PUSH_REASON="检测到核心记忆更改"
    PRIORITY="high"
    echo -e "${YELLOW}⭐ $PUSH_REASON${NC}"
fi

# 检查是否修改了配置文件
if git diff origin/main..HEAD --name-only | grep -q "config/CLAUDE.md"; then
    PUSH_REASON="检测到配置文件更改"
    PRIORITY="high"
    echo -e "${YELLOW}⭐ $PUSH_REASON${NC}"
fi

# 检查是否有重要决策
if git diff origin/main..HEAD --name-only | grep -q "memory/decisions/"; then
    PUSH_REASON="检测到决策记录更改"
    PRIORITY="high"
    echo -e "${YELLOW}⭐ $PUSH_REASON${NC}"
fi

# 检查更改数量
CHANGED_FILES=$(git diff origin/main..HEAD --name-only | wc -l)
if [ "$CHANGED_FILES" -gt 5 ]; then
    if [ -z "$PUSH_REASON" ]; then
        PUSH_REASON="检测到 $CHANGED_FILES 个文件更改"
        PRIORITY="medium"
        echo -e "${BLUE}📝 $PUSH_REASON${NC}"
    fi
fi

# 如果没有特殊原因，普通推送
if [ -z "$PUSH_REASON" ]; then
    PUSH_REASON="常规记忆更新"
    PRIORITY="low"
    echo -e "${GREEN}📝 $PUSH_REASON${NC}"
fi

echo ""

# 根据优先级决定推送策略
case "$PRIORITY" in
    "high")
        echo -e "${YELLOW}🔥 高优先级更改，立即推送...${NC}"
        git push origin main
        echo -e "${GREEN}✅ 立即推送完成${NC}"
        ;;

    "medium")
        echo -e "${BLUE}⏰ 中等优先级，5秒后推送（可Ctrl+C取消）${NC}"
        sleep 5
        git push origin main
        echo -e "${GREEN}✅ 推送完成${NC}"
        ;;

    "low")
        # 检查当前时间，避免深夜推送
        CURRENT_HOUR=$(date '+%H')
        if [ "$CURRENT_HOUR" -ge 22 ] || [ "$CURRENT_HOUR" -lt 8 ]; then
            echo -e "${YELLOW}🌙 深夜时段，加入推送队列${NC}"
            echo "$(date '+%Y-%m-%d %H:%M:%S') - $PUSH_REASON" >> .push_queue
            echo -e "${YELLOW}💤 将在下次定时任务时推送${NC}"
        else
            echo -e "${GREEN}📤 常规推送...${NC}"
            git push origin main
            echo -e "${GREEN}✅ 推送完成${NC}"
        fi
        ;;
esac

echo ""
echo -e "${BLUE}=== 同步完成 ===${NC}"
