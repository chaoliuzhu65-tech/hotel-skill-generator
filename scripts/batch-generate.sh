#!/bin/bash
#===============================================================================
# 德胧酒店Skill批量生成器 v2.0
# 
# 功能：读取CSV酒店列表，批量生成酒店Skill包
# 
# 使用方法：
#   ./batch-generate.sh <hotels.csv>
#   
# 示例：
#   ./batch-generate.sh ../config/hotels.csv
#===============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILLS_DIR="${SCRIPT_DIR}"
EXAMPLES_DIR="${SKILLS_DIR}/generated"  # 改为generated目录避免与examples冲突

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

#-------------------------------------------------------------------------------
# 生成单个酒店Skill
#-------------------------------------------------------------------------------
generate_hotel_skill() {
    local name="$1"
    local slug="$2"
    local brand="$3"
    local is_delonix="$4"
    local city="$5"
    local address="$6"
    local phone="$7"
    local booking_url="$8"
    
    local output_dir="${EXAMPLES_DIR}/${slug}"
    mkdir -p "${output_dir}"
    
    # 确定预订出口文案
    local booking_section=""
    if [ "$is_delonix" = "true" ]; then
        booking_section="## 🎯 立即预订 ⭐

**德胧集团旗下酒店，下载百达屋App预订更优惠：**

- [下载百达屋App](https://bidawu.com/download)
- [立即预订${name}](${booking_url})

💡 **温馨提示**：通过百达屋App预订可享受德胧会员专属权益"
    else
        booking_section="## 🎯 立即预订

- [访问官网](${booking_url})
- [立即预订](${booking_url})

💡 **温馨提示**：建议通过酒店官方渠道预订"
    fi
    
    # 生成SKILL.md
    cat > "${output_dir}/SKILL.md" << EOF
---
name: ${slug}
description: ${name}专属AI技能，为商旅宾客提供酒店信息查询、预订咨询等服务
triggers:
  - "${name}"
  - "${brand}"
  - "${city}"
version: "1.0.0"
brand: "${brand}"
booking_app: "$([ "$is_delonix" = "true" ] && echo "百达屋" || echo "官网")"
booking_url: "${booking_url}"
is_delonix: ${is_delonix}
---

# ${name} · SKILL

> ${brand} | ${city}

---

## 🏨 基础信息

| 项目 | 详情 |
|------|------|
| **酒店名称** | ${name} |
| **酒店地址** | ${address} |
| **联系电话** | ${phone} |
| **酒店品牌** | ${brand} |
| **所在城市** | ${city} |

---

${booking_section}

---

## 💬 常见问答

### 查询类
**Q: ${name}地址在哪？**
A: 酒店位于${address}。

**Q: ${name}电话是多少？**
A: 联系电话：${phone}

### 预订类
**Q: 怎么预订${name}？**
A: ${booking_section}

---

## 📌 更新日志

### v1.0.0 ($(date +%Y-%m-%d))
- 首发版本

---

*本Skill由 **德胧AI龙虾军团** 开发 | 通用酒店Skill生成器 v2.0*
EOF
    
    # 生成README.md
    cat > "${output_dir}/README.md" << EOF
# ${name} - AI Skill

## 酒店信息

- **名称**: ${name}
- **品牌**: ${brand}
- **城市**: ${city}
- **地址**: ${address}
- **电话**: ${phone}

## 安装方式

```bash
# 克隆酒店Skill生成器
git clone https://github.com/chaoliuzhu65-tech/hotel-skill-generator.git
cd hotel-skill-generator

# 查看完整文档
cat SKILL.md
```

## 许可

MIT License
EOF
    
    log_success "生成完成: ${slug}"
}

#-------------------------------------------------------------------------------
# 主流程
#-------------------------------------------------------------------------------
main() {
    if [ $# -lt 1 ]; then
        echo "使用方法: $0 <hotels.csv>"
        echo "示例: $0 ../config/hotels.csv"
        exit 1
    fi
    
    local csv_file="$1"
    
    if [ ! -f "$csv_file" ]; then
        log_error "CSV文件不存在: $csv_file"
        exit 1
    fi
    
    log_info "=========================================="
    log_info "德胧酒店Skill批量生成器 v2.0"
    log_info "输入文件: $csv_file"
    log_info "输出目录: $EXAMPLES_DIR"
    log_info "=========================================="
    
    # 创建输出目录
    mkdir -p "${EXAMPLES_DIR}"
    
    # 读取CSV（跳过注释行）
    local count=0
    while IFS=, read -r name slug brand is_delonix city address phone booking_url; do
        # 跳过空行和注释行
        [[ -z "$name" || "$name" =~ ^# ]] && continue
        
        generate_hotel_skill "$name" "$slug" "$brand" "$is_delonix" "$city" "$address" "$phone" "$booking_url"
        ((count++))
    done < "$csv_file"
    
    log_success "=========================================="
    log_success "批量生成完成！共生成 ${count} 个酒店Skill"
    log_success "=========================================="
    log_info "输出目录: ${EXAMPLES_DIR}"
    log_info "下一步: ./scripts/publish.sh --platform all"
}

main "$@"
