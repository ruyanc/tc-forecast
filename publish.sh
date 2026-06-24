#!/bin/bash
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#  WRF 台风预报网页发布脚本
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
#
#  用途：将新的预报 HTML 文件发布到 GitHub Pages
#
#  使用方法：
#    bash publish.sh <html_filename>
#
#  示例：
#    bash publish.sh track_2026062412_nrt.html
#    bash publish.sh track_2026062312_nrt.html "添加自定义提交信息"
#
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

set -e

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# ────────────────────────────────────────────────────────────────────────────
#  参数检查
# ────────────────────────────────────────────────────────────────────────────

if [ $# -eq 0 ]; then
    echo -e "${RED}错误：缺少 HTML 文件名参数${NC}"
    echo ""
    echo "用法："
    echo "  bash publish.sh <html_filename> [commit_message]"
    echo ""
    echo "示例："
    echo "  bash publish.sh track_2026062412_nrt.html"
    echo "  bash publish.sh track_2026062412_nrt.html \"更新 2026-06-24 12Z 预报\""
    exit 1
fi

HTML_FILE="$1"
COMMIT_MSG="${2:-}"

# ────────────────────────────────────────────────────────────────────────────
#  文件检查
# ────────────────────────────────────────────────────────────────────────────

if [ ! -f "$HTML_FILE" ]; then
    echo -e "${RED}错误：文件不存在: $HTML_FILE${NC}"
    echo ""
    echo "当前目录下的 HTML 文件："
    ls -lh *.html 2>/dev/null || echo "  (无)"
    exit 1
fi

# 提取预报时间（假设格式为 track_YYYYMMDDHH_*.html）
TAG=$(basename "$HTML_FILE" .html | sed 's/^track_//' | sed 's/_nrt.*//')

# 生成默认提交信息
if [ -z "$COMMIT_MSG" ]; then
    if [[ "$TAG" =~ ^[0-9]{10}$ ]]; then
        YEAR=${TAG:0:4}
        MONTH=${TAG:4:2}
        DAY=${TAG:6:2}
        HOUR=${TAG:8:2}
        COMMIT_MSG="更新预报：${YEAR}-${MONTH}-${DAY} ${HOUR}Z"
    else
        COMMIT_MSG="更新预报文件：$HTML_FILE"
    fi
fi

# ────────────────────────────────────────────────────────────────────────────
#  开始发布流程
# ────────────────────────────────────────────────────────────────────────────

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  🚀 WRF 预报网页发布"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "${GREEN}HTML 文件:${NC} $HTML_FILE"
echo -e "${GREEN}文件大小:${NC} $(du -h "$HTML_FILE" | cut -f1)"
echo -e "${GREEN}提交信息:${NC} $COMMIT_MSG"
echo ""

# ────────────────────────────────────────────────────────────────────────────
#  更新 index.html 软链接
# ────────────────────────────────────────────────────────────────────────────

echo "→ 更新 index.html 软链接..."

if [ -L index.html ]; then
    OLD_TARGET=$(readlink index.html)
    if [ "$OLD_TARGET" = "$HTML_FILE" ]; then
        echo "  ℹ️  index.html 已指向 $HTML_FILE，无需更新"
    else
        echo "  旧目标: $OLD_TARGET"
        rm -f index.html
        ln -s "$HTML_FILE" index.html
        echo -e "  ${GREEN}✓ 已更新为: $HTML_FILE${NC}"
    fi
else
    rm -f index.html
    ln -s "$HTML_FILE" index.html
    echo -e "  ${GREEN}✓ 已创建软链接: index.html → $HTML_FILE${NC}"
fi

# ────────────────────────────────────────────────────────────────────────────
#  Git 操作
# ────────────────────────────────────────────────────────────────────────────

echo ""
echo "→ 添加文件到 Git..."

# 添加 HTML 文件和 index.html
git add "$HTML_FILE" index.html

# 检查是否有其他更改需要提交
if git diff --cached --quiet; then
    echo -e "${YELLOW}  ℹ️  没有新的更改需要提交${NC}"
    echo ""
    echo "当前 index.html 指向: $(readlink index.html)"
    exit 0
fi

# 显示将要提交的文件
echo ""
echo "  将要提交的文件："
git diff --cached --name-status | sed 's/^/    /'

# ────────────────────────────────────────────────────────────────────────────
#  提交
# ────────────────────────────────────────────────────────────────────────────

echo ""
echo "→ 提交到本地仓库..."
git commit -m "$COMMIT_MSG"
echo -e "${GREEN}  ✓ 提交成功${NC}"

# ────────────────────────────────────────────────────────────────────────────
#  推送
# ────────────────────────────────────────────────────────────────────────────

echo ""
echo "→ 推送到 GitHub..."
git push origin main

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "  ${GREEN}✅ 发布成功${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "网站将在 1-2 分钟内更新："
echo "  https://ruyanc.github.io/tc-forecast/"
echo ""
echo "查看部署状态："
echo "  https://github.com/ruyanc/tc-forecast/actions"
echo ""

