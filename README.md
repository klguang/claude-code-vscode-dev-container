# Claude Code Dev Container

适用于 VS Code Dev Containers 的 Claude Code 模板。

特点：

- 使用中国镜像源，构建镜像更快，更适合中国大陆用户
- 默认启用 Claude Code 无人值守模式（`bypassPermissions`）
- 免登录，可直接在 `.env` 配置第三方兼容网关的认证令牌
- `Reopen in Container` 后自动在容器侧安装 `Claude Code` 扩展
- 容器启动时自动预信任当前工作区，避免首次手动确认 trust

## 模板

- [mcr-cluade-code](D:/workspace/claude-code/dev-container/mcr-cluade-code)：轻量版，基于 TypeScript/Node devcontainer
- [mcr-cluade-code-ubuntu](D:/workspace/claude-code/dev-container/mcr-cluade-code-ubuntu)：配置更完整，额外包含 `npmmirror`

两份模板都已配置：

- `mcr.m.daocloud.io` 是 DaoCloud 提供的 MCR 国内镜像加速地址，用于加速拉取基础镜像
- 阿里云 APT 源
- Claude Code 无人值守（`bypassPermissions`）

## 使用

1. 选择一个模板目录
2. 将 `.env.example` 复制为 `.env`
3. 填写 API、模型和代理
4. 在 VS Code 中执行 `Dev Containers: Rebuild and Reopen in Container`
5. 等待容器初始化，并等待 `Claude Code` 扩展自动安装到 `Dev Container` 侧
6. 直接使用 VS Code 的 Claude Code 面板，或在容器终端运行 `claude`

## `.env` 示例

```env
ANTHROPIC_AUTH_TOKEN=your_api_key
ANTHROPIC_MODEL=ark-code-latest
ANTHROPIC_BASE_URL=https://ark.cn-beijing.volces.com/api/coding
HTTP_PROXY=http://host.docker.internal:33210
HTTPS_PROXY=http://host.docker.internal:33210
```

相关文件：

- [mcr-cluade-code/.env.example](D:/workspace/claude-code/dev-container/mcr-cluade-code/.env.example)
- [mcr-cluade-code-ubuntu/.env.example](D:/workspace/claude-code/dev-container/mcr-cluade-code-ubuntu/.env.example)

注意：

- `.env` 只能写 `KEY=VALUE`
- 认证变量已切换为 `ANTHROPIC_AUTH_TOKEN`
- 如果继续使用 `ANTHROPIC_API_KEY`，Claude Code 会按当前官方行为弹出自定义 API Key 确认提示
- Git 代理会在容器创建后自动同步
- 当前代理只覆盖容器运行期，不覆盖 Docker build 阶段
- 修改 `.devcontainer` 配置后，需要执行 `Dev Containers: Rebuild Container`
- 适合可信仓库，不建议直接用于不受信任的外部项目

## 容器侧初始化说明

- 模板已通过 `devcontainer.json` 预装 `anthropic.claude-code`
- `setup-proxy.sh` 只负责同步 Git 代理设置
- `setup-claude.sh` 只负责按当前工作区路径写入 Claude trust 状态
- Dockerfile 中的 Claude 初始化只写静态默认值，例如 `permissions.defaultMode`、`skipDangerousModePermissionPrompt` 和 `hasCompletedOnboarding`
- 模板默认仍使用 `bypassPermissions`，并预写跳过风险确认提示的用户设置
- 模板默认把容器时区设为 `Asia/Shanghai`
- 当前工作区路径只有在容器启动时才能确定，所以 trust 不能只写在 Dockerfile 中
