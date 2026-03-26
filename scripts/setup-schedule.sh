#!/bin/bash
# 定时任务配置脚本
# 设置每日定时推送

set -euo pipefail

MEMORY_DIR="${MEMORY_DIR:-$HOME/.adaptive-memory}"

# 颜色输出
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== 配置定时同步任务 ===${NC}"
echo ""

# 检测操作系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    OS="windows"
fi

echo -e "${BLUE}检测到操作系统: $OS${NC}"
echo ""

case "$OS" in
    "mac"|"linux")
        # 配置 crontab
        echo -e "${BLUE}配置 crontab 定时任务...${NC}"
        echo ""

        # 检查是否已配置
        if crontab -l 2>/dev/null | grep -q "daily-sync.sh"; then
            echo -e "${YELLOW}⚠️  检测到已存在的定时任务${NC}"
            read -p "是否重新配置？(y/N) " -n 1 -r
            echo
            if [[ ! $REPLY =~ ^[Yy]$ ]]; then
                echo "跳过配置"
                exit 0
            fi

            # 删除旧的任务
            crontab -l | grep -v "daily-sync.sh" | crontab -
        fi

        # 添加新的定时任务
        (crontab -l 2>/dev/null; echo "# 每日记忆同步 - 晚上10点") | crontab -
        (crontab -l 2>/dev/null; echo "0 22 * * * cd $MEMORY_DIR && bash scripts/daily-sync.sh >> ~/.memory-sync.log 2>&1") | crontab -

        echo -e "${GREEN}✅ 定时任务配置成功${NC}"
        echo ""
        echo "📋 定时任务内容："
        echo "  - 时间：每天晚上 22:00"
        echo "  - 脚本：$MEMORY_DIR/scripts/daily-sync.sh"
        echo "  - 日志：~/.memory-sync.log"
        echo ""
        echo "💡 查看定时任务："
        echo "  crontab -l"
        echo ""
        echo "💡 查看同步日志："
        echo "  tail -f ~/.memory-sync.log"
        ;;

    "windows")
        echo -e "${YELLOW}Windows 系统配置说明：${NC}"
        echo ""
        echo "由于 Windows 需要手动配置任务计划程序，请按以下步骤操作："
        echo ""
        echo "1. 打开「任务计划程序」"
        echo "   - Win + R，输入 taskschd.msc"
        echo ""
        echo "2. 创建基本任务"
        echo "   - 名称：每日记忆同步"
        echo "   - 触发器：每天 22:00"
        echo "   - 操作：启动程序"
        echo ""
        echo "3. 程序设置："
        echo "   - 程序：bash"
        echo "   - 参数：$MEMORY_DIR/scripts/daily-sync.sh"
        echo ""
        echo "或者使用 PowerShell 命令："
        echo ""
        echo '$action = New-ScheduledTaskAction -Execute "bash" -Argument "'"$MEMORY_DIR"'/scripts/daily-sync.sh"'
        echo '$trigger = New-ScheduledTaskTrigger -Daily -At "22:00"'
        echo 'Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "每日记忆同步"'
        ;;

    *)
        echo -e "${RED}❌ 不支持的操作系统：$OS${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${GREEN}=== 定时同步配置完成 ===${NC}"
echo ""
echo "📝 组合策略说明："
echo "  1. 会话结束：自动推送（Git hooks）"
echo "  2. 每天晚上：定时推送（crontab）"
echo "  3. 重要记忆：手动立即推送"
echo ""
echo "🚀 配置完成！记忆系统现在会自动同步了！"
