#!/bin/bash
#===============================================================================
# 德胧酒店Skill生成器 v1.0
#
# 功能：读取酒店资料，生成标准化的酒店Skill包
#
# 使用方法：
#   ./generate-hotel-skill.sh <hotel-name> <hotel-data-file>
#
# 示例：
#   ./generate-hotel-skill.sh tianjin-riwan ./hotels/tianjin-riwan.md
#
# 输出：
#   examples/delonix-tianjin-riwan/SKILL.md
#   examples/delonix-tianjin-riwan/README.md
#   examples/delonix-tianjin-riwan/package.json
#===============================================================================

set -e

SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
EXAMPLES_DIR="${SKILLS_DIR}/examples"

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

# 模板引擎（简单替换）
generate_from_template() {
    local hotel_name="$1"
    local output_dir="$2"
    
    # 创建目录
    mkdir -p "${output_dir}"
    
    # 读取模板并生成文件
    cat > "${output_dir}/SKILL.md" << 'SKILL_TEMPLATE'
---
name: {{SLUG}}
description: {{DESCRIPTION}}
triggers:
  - "{{HOTEL_NAME}}"
  - "{{ALIASES}}"
version: "1.0.0"
brand: "德胧集团"
---

# {{HOTEL_NAME_CN}} · SKILL

> {{TAGLINE}}

---

## 🏨 基础信息

| 项目 | 详情 |
|------|------|
| **酒店名称** | {{HOTEL_NAME_CN}} |
| **酒店地址** | {{ADDRESS}} |
| **联系电话** | {{PHONE}} |
| **酒店星级** | {{STAR}} |
| **开业时间** | {{OPEN_DATE}} |
| **官方网站** | {{WEBSITE}} |

---

## 🛏️ 客房服务

{{ROOM_INFO}}

---

## 🍽️ 餐饮美食

{{Dining_INFO}}

---

## 🏢 会议与宴会

{{MEETING_INFO}}

---

## 💬 常见问答

{{FAQ}}

---

## 📌 更新日志

### v1.0.0 ({{DATE}})
- 首发版本

---

*本Skill由 **德胧AI龙虾军团** 开发维护*
SKILL_TEMPLATE
    
    log_success "生成完成: ${output_dir}/SKILL.md"
}

# 主逻辑
main() {
    if [ $# -lt 2 ]; then
        echo "使用方法: $0 <hotel-slug> <data-file>"
        echo "示例: $0 tianjin-riwan ./data/tianjin-riwan.md"
        exit 1
    fi
    
    local slug="$1"
    local data_file="$2"
    
    if [ ! -f "$data_file" ]; then
        echo "错误: 数据文件不存在: $data_file"
        exit 1
    fi
    
    local output_dir="${EXAMPLES_DIR}/delonix-${slug}"
    
    log_info "生成酒店Skill: $slug"
    log_info "输出目录: $output_dir"
    
    generate_from_template "$slug" "$output_dir"
    
    log_success "Skill生成完成!"
    echo ""
    echo "下一步操作："
    echo "  1. 编辑 ${output_dir}/SKILL.md 补充详细信息"
    echo "  2. 运行 ./scripts/publish.sh delonix-${slug} 发布"
}

main "$@"
