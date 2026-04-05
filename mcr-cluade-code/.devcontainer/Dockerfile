FROM mcr.m.daocloud.io/devcontainers/typescript-node:4-24-trixie
ARG DEBIAN_FRONTEND=noninteractive

RUN rm -f /etc/apt/sources.list.d/debian.sources \
 && printf "deb https://mirrors.aliyun.com/debian/ trixie main contrib non-free non-free-firmware\n\
deb https://mirrors.aliyun.com/debian/ trixie-updates main contrib non-free non-free-firmware\n\
deb https://mirrors.aliyun.com/debian-security trixie-security main contrib non-free non-free-firmware\n" \
 > /etc/apt/sources.list \
 && apt-get update

# 安装常用工具 + 依赖
RUN apt-get update -o Acquire::Retries=3 \
 && apt-get install -y \
    git \
    wget \
    zip \
    curl \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 全局安装最新版Claude Code
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

WORKDIR /workspace
