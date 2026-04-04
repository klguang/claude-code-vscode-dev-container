# Claude Code Dev Container

适用于 VS Code Dev Containers 的 Claude Code 模板。

特点：

- 默认启用 Claude Code 无人值守模式
- 免登录，可直接在 `.env` 配置第三方兼容网关的 API Key
- 更适合中国大陆用户

## 模板

- [mcr-cluade-code](D:/workspace/claude-code/dev-container/mcr-cluade-code)：轻量版，基于 TypeScript/Node devcontainer
- [mcr-cluade-code-ubuntu](D:/workspace/claude-code/dev-container/mcr-cluade-code-ubuntu)：配置更完整，额外包含 `npmmirror`

两份模板都已配置：

- `mcr.m.daocloud.io` 基础镜像
- 阿里云 APT 源
- Claude Code 无人值守

## 使用

1. 选择一个模板目录
2. 将 `.env.example` 复制为 `.env`
3. 填写 API、模型和代理
4. 在 VS Code 中执行 `Dev Containers: Reopen in Container`
5. 在容器终端运行 `claude`

## `.env` 示例

```env
ANTHROPIC_API_KEY=your_key
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
- Git 代理会在容器创建后自动同步
- 当前代理只覆盖容器运行期，不覆盖 Docker build 阶段
- 适合可信仓库，不建议直接用于不受信任的外部项目
