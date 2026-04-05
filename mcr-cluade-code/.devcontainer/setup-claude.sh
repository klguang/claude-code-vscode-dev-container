#!/usr/bin/env bash

set -euo pipefail

# trust 是按工作区路径存储的，必须在容器启动后按当前 workspace 写入。
workspace_path="${1:-${PWD}}"

node - "$workspace_path" <<'NODE'
const fs = require("fs");
const os = require("os");
const path = require("path");

const inputPath = process.argv[2];
const homeDir = process.env.HOME || os.homedir();
const statePath = path.join(homeDir, ".claude.json");

function readJson(filePath) {
  try {
    return JSON.parse(fs.readFileSync(filePath, "utf8"));
  } catch {
    return {};
  }
}

function resolveWorkspace(filePath) {
  try {
    return fs.realpathSync.native(filePath).normalize("NFC");
  } catch {
    return path.resolve(filePath).normalize("NFC");
  }
}

const workspacePath = resolveWorkspace(inputPath);
const state = readJson(statePath);
state.projects = state.projects ?? {};
state.projects[workspacePath] = {
  ...(state.projects[workspacePath] ?? {}),
  hasTrustDialogAccepted: true,
};
fs.writeFileSync(statePath, `${JSON.stringify(state, null, 2)}\n`, "utf8");
NODE
