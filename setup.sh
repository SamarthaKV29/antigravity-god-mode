#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/SamarthaKV29/antigravity-god-mode.git"
CONFIG_ROOT="${HOME}/.gemini/config"
UPDATE_EXISTING=0
LINK_IDE=0

for arg in "$@"; do
  case "${arg}" in
    --update|-u) UPDATE_EXISTING=1 ;;
    --link-ide) LINK_IDE=1 ;;
    --help|-h)
      echo "Usage: setup.sh [--update] [--link-ide]"
      echo "  Default:    additive/non-destructive (creates missing config items only; preserves existing files)."
      echo "  --update:   updates existing repo-managed files after saving .bak backups when modified."
      echo "  --link-ide: optional — symlinks ~/.gemini/antigravity & ~/.gemini/antigravity-ide to ~/.gemini/config."
      exit 0
      ;;
  esac
done

CORE_SKILLS=(
  "api-design-principles"
  "architecture"
  "clean-code"
  "commit"
  "concise-planning"
  "debugger"
  "error-handling-patterns"
  "skill-picker"
  "subagent-routing"
  "testing-patterns"
)

repair_core_skills() {
  local root_dir="$1"
  local skills_dir="${root_dir}/skills"
  local catalog_dir="${root_dir}/skills-catalog"
  [[ -d "${catalog_dir}" ]] || return 0
  mkdir -p "${skills_dir}"

  for skill in "${CORE_SKILLS[@]}"; do
    local src="${catalog_dir}/${skill}"
    local dst="${skills_dir}/${skill}"
    [[ -d "${src}" ]] || continue
    if [[ ! -d "${dst}" || -L "${dst}" || ! -f "${dst}/SKILL.md" ]]; then
      rm -rf "${dst}"
      cp -R "${src}" "${dst}"
      echo "[+] Populated core skill directory: ${skill}"
    fi
  done
}

sync_dir_safe() {
  local src_dir="$1"
  local dst_dir="$2"
  [[ -d "${src_dir}" ]] || return 0
  mkdir -p "${dst_dir}"

  local added=0
  local updated=0
  local skipped=0

  while IFS= read -r -d '' src_file; do
    local rel="${src_file#"${src_dir}/"}"
    local dst_file="${dst_dir}/${rel}"
    mkdir -p "$(dirname "${dst_file}")"

    if [[ ! -e "${dst_file}" && ! -L "${dst_file}" ]]; then
      cp -p "${src_file}" "${dst_file}"
      added=$((added + 1))
    elif [[ "${UPDATE_EXISTING}" -eq 1 ]]; then
      if ! cmp -s "${src_file}" "${dst_file}"; then
        local stamp
        stamp="$(date +%Y%m%d%H%M%S)"
        cp -p "${dst_file}" "${dst_file}.bak.${stamp}"
        cp -p "${src_file}" "${dst_file}"
        updated=$((updated + 1))
      fi
    else
      skipped=$((skipped + 1))
    fi
  done < <(find "${src_dir}" -type f -print0)

  echo "[+] ${dst_dir} -> added: ${added}, updated: ${updated}, preserved existing: ${skipped}"
}

ensure_symlink() {
  local link_path="$1"
  local target_path="$2"
  mkdir -p "${target_path}" "$(dirname "${link_path}")"

  if [[ -L "${link_path}" ]]; then
    local current
    current="$(readlink "${link_path}")"
    if [[ "${current}" == "${target_path}" ]]; then
      return 0
    fi
    ln -sfn "${target_path}" "${link_path}"
    echo "[+] Updated link ${link_path} -> ${target_path}"
  elif [[ -e "${link_path}" ]]; then
    echo "[=] Kept existing path: ${link_path} (not overwritten)"
  else
    ln -s "${target_path}" "${link_path}"
    echo "[+] Linked ${link_path} -> ${target_path}"
  fi
}

# Resolve source: local repo clone OR 1-step remote bootstrap (curl ... | bash)
set +u
SCRIPT_DIR=""
if [[ -n "${BASH_SOURCE[0]}" && -f "${BASH_SOURCE[0]}" ]]; then
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi
set -u

TEMP_CLONE=""
cleanup() {
  if [[ -n "${TEMP_CLONE}" && -d "${TEMP_CLONE}" ]]; then
    rm -rf "${TEMP_CLONE}"
  fi
}
trap cleanup EXIT

if [[ -n "${SCRIPT_DIR}" && -f "${SCRIPT_DIR}/rules/GEMINI.md" ]]; then
  REPO_ROOT="${SCRIPT_DIR}"
else
  if ! command -v git >/dev/null 2>&1; then
    echo "[!] Git is required for one-step remote install." >&2
    exit 1
  fi
  if [[ ! -d "${CONFIG_ROOT}" ]]; then
    echo "[*] Cloning antigravity-god-mode directly into ${CONFIG_ROOT}..."
    mkdir -p "$(dirname "${CONFIG_ROOT}")"
    git clone --depth 1 "${REPO_URL}" "${CONFIG_ROOT}"
    REPO_ROOT="${CONFIG_ROOT}"
  else
    TEMP_CLONE="$(mktemp -d)"
    echo "[*] Existing config detected at ${CONFIG_ROOT}. Fetching latest repo to staging..."
    git clone --depth 1 "${REPO_URL}" "${TEMP_CLONE}"
    REPO_ROOT="${TEMP_CLONE}"
  fi
fi

echo "[*] Verifying core skills in ${REPO_ROOT}/skills..."
repair_core_skills "${REPO_ROOT}"

REAL_REPO="$(cd "${REPO_ROOT}" && pwd -P)"
mkdir -p "${CONFIG_ROOT}"
REAL_CONFIG="$(cd "${CONFIG_ROOT}" && pwd -P)"

if [[ "${REAL_REPO}" != "${REAL_CONFIG}" ]]; then
  if [[ "${UPDATE_EXISTING}" -eq 1 ]]; then
    echo "[*] Syncing customizations to ${CONFIG_ROOT} [update with .bak backups]..."
  else
    echo "[*] Syncing customizations to ${CONFIG_ROOT} [additive: new/missing only]..."
  fi

  for dir in rules skills skills-catalog workflows global_workflows; do
    sync_dir_safe "${REPO_ROOT}/${dir}" "${CONFIG_ROOT}/${dir}"
  done

  for plugin in antigravity-god-mode agency-agents; do
    if [[ -d "${REPO_ROOT}/plugins/${plugin}" ]]; then
      sync_dir_safe "${REPO_ROOT}/plugins/${plugin}" "${CONFIG_ROOT}/plugins/${plugin}"
    fi
  done
else
  repair_core_skills "${CONFIG_ROOT}"
fi

if [[ "${LINK_IDE}" -eq 1 ]]; then
  echo "[*] Linking missing slots in Antigravity & Antigravity IDE to ${CONFIG_ROOT}..."
  mkdir -p "${HOME}/.gemini/antigravity" "${HOME}/.gemini/antigravity-ide"
  for item in rules skills workflows global_workflows plugins; do
    ensure_symlink "${HOME}/.gemini/antigravity/${item}" "${CONFIG_ROOT}/${item}"
    ensure_symlink "${HOME}/.gemini/antigravity-ide/${item}" "${CONFIG_ROOT}/${item}"
  done

  ensure_symlink "${HOME}/.gemini/antigravity/conversations" "${HOME}/.gemini/antigravity-ide/conversations"
  ensure_symlink "${HOME}/.gemini/antigravity/brain" "${HOME}/.gemini/antigravity-ide/brain"
  ensure_symlink "${HOME}/.gemini/antigravity/code_tracker" "${HOME}/.gemini/antigravity-ide/code_tracker"
fi

echo "[+] antigravity-god-mode setup complete! (Existing user configs preserved)"
if [[ "${LINK_IDE}" -eq 0 ]]; then
  echo "[i] Optional dual-IDE linking skipped. Pass --link-ide if you want to symlink ~/.gemini/antigravity & ~/.gemini/antigravity-ide."
fi
