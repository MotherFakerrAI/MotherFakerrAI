#!/bin/bash

# GitHub Profile 部署脚本
# 自动推送到 MotherFakerrAI 仓库

set -e

echo "🚀 开始部署 GitHub Profile..."

# 检查是否已登录 GitHub
if ! gh auth status &> /dev/null; then
    echo "❌ 请先登录 GitHub: gh auth login"
    exit 1
fi

# 进入项目目录
cd "$(dirname "$0")"

# 初始化 Git（如果是第一次）
if [ ! -d ".git" ]; then
    echo "📦 初始化 Git 仓库..."
    git init
    git add .
    git commit -m "feat: add GitHub Profile README with terminal style"
fi

# 创建/更新 README 到 MotherFakerrAI 仓库
PROFILE_REPO="MotherFakerrAI/MotherFakerrAI"

echo "📤 推送到 GitHub: $PROFILE_REPO"

# 检查仓库是否存在
if gh repo view $PROFILE_REPO &> /dev/null; then
    echo "✅ 仓库已存在"
else
    echo "🆕 创建仓库..."
    gh repo create $PROFILE_REPO --public --description="MotherFaker Studio GitHub Profile"
fi

# 推送文件
git remote add origin https://github.com/$PROFILE_REPO.git 2>/dev/null || true
git branch -M main
git push -u origin main --force

echo ""
echo "✅ 部署完成！"
echo ""
echo "📍 访问地址："
echo "   https://github.com/MotherFakerrAI"
echo ""
echo "🎨 预览效果可能需要几分钟刷新..."
