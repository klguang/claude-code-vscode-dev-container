# Claude Code Dev Container

适用于 VS Code Dev Containers 的 Claude Code 模板，重点是：

- 默认启用 Claude Code 无人值守模式
- 更适合中国大陆网络环境

## 特点

- 无人值守：容器内已预置 `bypassPermissions`，适合长任务和自动执行
- 免登录：跳过首次启动引导，不需要先登录 Claude 账号
- 可直连第三方网关：直接在 `.env` 中配置 `ANTHROPIC_API_KEY`、`ANTHROPIC_MODEL`、`ANTHROPIC_BASE_URL`
- 大陆友好：使用 `mcr.m.daocloud.io`，Ubuntu 模板内置阿里云 APT 源和 `npmmirror`
- 代理预留：`.env.example` 已提供 `HTTP_PROXY` 和 `HTTPS_PROXY`
- 网关兼容：Ubuntu 模板默认示例使用 `ark-code-latest`

说明：这是给可信仓库准备的配置；无人值守模式不适合直接处理不受信任的项目。

## 模板

- [mcr-cluade-code](D:/workspace/claude-code/dev-container/mcr-cluade-code)：更轻量，基于 TypeScript/Node devcontainer
- [mcr-cluade-code-ubuntu](D:/workspace/claude-code/dev-container/mcr-cluade-code-ubuntu)：更适合中国大陆用户，默认配置更完整

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

说明：这个模板的默认使用方式不是网页登录，而是直接在 `.env` 中填写第三方兼容网关的 API Key、模型名和服务地址。

相关模板文件：

- [mcr-cluade-code/.env.example](D:/workspace/claude-code/dev-container/mcr-cluade-code/.env.example)
- [mcr-cluade-code-ubuntu/.env.example](D:/workspace/claude-code/dev-container/mcr-cluade-code-ubuntu/.env.example)

注意：

- `.env` 只能写 `KEY=VALUE`
- Git 代理会在容器创建后由 `setup-proxy.sh` 自动同步
- 当前代理只覆盖容器运行期，不覆盖 Docker build 阶段
