FROM mcr.m.daocloud.io/devcontainers/base:ubuntu-24.04

# APT 源换成国内镜像
RUN rm -f /etc/apt/sources.list.d/ubuntu.sources \
 && printf "deb https://mirrors.aliyun.com/ubuntu/ noble main restricted universe multiverse\n\
deb https://mirrors.aliyun.com/ubuntu/ noble-security main restricted universe multiverse\n\
deb https://mirrors.aliyun.com/ubuntu/ noble-updates main restricted universe multiverse\n\
deb https://mirrors.aliyun.com/ubuntu/ noble-backports main restricted universe multiverse\n" \
 > /etc/apt/sources.list \
 && apt-get update

# 安装常用工具 + 依赖
RUN apt-get install -y \
    vim \
    git \
    wget \
    zip \
    curl \
    ca-certificates \
    tmux \
    && rm -rf /var/lib/apt/lists/*

# 安装 Node
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash \
 && apt-get install -y nodejs
RUN npm config set registry https://registry.npmmirror.com

# 安装 TypeScript 
RUN npm install -g typescript ts-node @types/node

# 安装 Claude Code
RUN npm install -g @anthropic-ai/claude-code@latest

# 如果 vscode 用户不存在（极少数情况），则创建
RUN if ! id -u vscode > /dev/null 2>&1; then \
        useradd -m -s /bin/bash vscode; \
    fi \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ENV HOME=/home/vscode
USER vscode

# ==================== 新增：预配置Claude无人值守模式（固化到镜像） ====================
RUN mkdir -p ~/.claude \
    # 单引号包裹JSON无需转义，更不易出错
    && echo '{"permissions": {"defaultMode": "bypassPermissions"}}' > ~/.claude/settings.json \
    && echo '{"hasCompletedOnboarding": true}' > ~/.claude.json
# ================================================================================

WORKDIR /workspaces