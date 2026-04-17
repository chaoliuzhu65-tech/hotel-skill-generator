# 德胧酒店Skill批量生成与发布平台 - 整体设计方案 v2.0

> **项目目标**：为所有酒店生成专属AI Skill，成为酒店行业标配工具
> **负责人**：德胧AI龙虾军团
> **版本**：v2.0（2026-04-17重大升级）
> **灵感来源**：金谷园饺子馆Skill + Coze智能体生态

---

## 一、项目愿景

### 1.1 核心目标

**让每一家酒店都拥有专属AI Skill**

不是仅限于德胧，而是面向整个酒店行业：
- 德胧旗下40+酒店 → 引导到百达屋App
- 其他酒店 → 引导到酒店官网/官方预订

### 1.2 行业背景

**金谷园饺子馆案例**：
- 北邮旁边饺子馆老板（北邮计算机专业毕业）用几小时开发
- 基于MCP协议，支持美团在线取号
- GitHub开源后冲上热搜，美团主动合作
- 成为"全国第一家接入AI智能体生态的传统餐饮品牌"

**德胧的机会**：
- 40+酒店 = 40+ AI服务入口
- 开创酒店行业"AI原生服务"新标准
- 通过百达屋App实现订单转化

---

## 二、v2.0 核心升级

### 2.1 升级对比

| 维度 | v1.0 | v2.0 |
|------|------|------|
| **适用范围** | 仅德胧酒店 | 全行业酒店 |
| **预订出口** | 手动设置 | 智能适配 |
| **百达屋对接** | 无 | ✅ 核心出口 |
| **非德胧适配** | 无 | ✅ 支持 |
| **Coze发布** | 无 | ✅ 支持 |
| **批量生成** | 基础 | ✅ 完整工作流 |

### 2.2 百达屋App核心出口

所有德胧酒店Skill统一引导到百达屋App：

```markdown
## 🎯 立即预订 ⭐

**德胧集团旗下酒店，下载百达屋App预订更优惠：**

- [下载百达屋App](https://bidawu.com/download)
- [立即预订](https://bidawu.com/hotel/{hotel-slug})

💡 **温馨提示**：通过百达屋App预订可享受德胧会员专属权益
```

### 2.3 非德胧酒店适配

非德胧酒店引导到酒店官网：

```markdown
## 🎯 立即预订

- [访问官网](https://hotel-official.com)
- [立即预订](https://hotel-official.com/book)

💡 **温馨提示**：建议通过酒店官方渠道预订
```

---

## 三、技术架构

### 3.1 系统架构

```
┌─────────────────────────────────────────────────────────────┐
│               酒店Skill生成器 v2.0                         │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│  ┌───────────────┐    ┌───────────────┐                   │
│  │  单酒店生成   │    │   批量生成    │                   │
│  │  hotel.yaml   │    │   hotels.csv  │                   │
│  └───────┬───────┘    └───────┬───────┘                   │
│          │                    │                            │
│          └─────────┬──────────┘                            │
│                    ▼                                         │
│         ┌──────────────────┐                               │
│         │   SKILL生成引擎   │                               │
│         │   (Mustache模板)  │                               │
│         └────────┬─────────┘                               │
│                  │                                          │
│     ┌────────────┼────────────┐                           │
│     ▼            ▼            ▼                            │
│ ┌────────┐  ┌────────┐  ┌────────┐                        │
│ │ GitHub │  │ClawHub │  │  Coze  │                        │
│ │  开源  │  │ OpenClaw│  │ 字节AI │                        │
│ └────────┘  └────────┘  └────────┘                        │
│                                                             │
│     ┌────────────────────────────────┐                     │
│     │       预订出口智能适配          │                     │
│     │  德胧酒店 → 百达屋App           │                     │
│     │  非德胧酒店 → 酒店官网          │                     │
│     └────────────────────────────────┘                     │
└─────────────────────────────────────────────────────────────┘
```

### 3.2 目录结构

```
hotel-skill-generator/
├── SKILL.md                      # 元技能核心文档
├── ARCHITECTURE.md              # 本文件
├── README.md                    # 项目说明
├── config/
│   ├── hotel-template.yaml     # 单酒店配置模板
│   ├── hotels-template.csv     # 批量酒店列表模板
│   └── platforms.yaml          # 平台配置
├── scripts/
│   ├── generate.sh             # 生成单酒店Skill
│   ├── batch-generate.sh       # 批量生成（新增）
│   ├── publish.sh              # 单酒店发布
│   ├── batch-publish.sh        # 批量发布（新增）
│   └── coze-deploy.sh          # Coze部署（新增）
└── templates/
    ├── SKILL-template.md        # Skill模板
    └── README-template.md       # README模板
```

---

## 四、核心方法论

### 4.1 Skill = 触发词 + 知识库 + 交互场景 + 预订出口

```
Step 1: 定义触发词（triggers）
        ↓
        用户怎么称呼这个酒店
        示例：天津瑞湾 | 瑞湾开元名都 | 天津酒店

Step 2: 整理知识库（knowledge）
        ↓
        地址、电话、营业时间、特色服务

Step 3: 设计交互场景（scenarios）
        ↓
        用户问什么？怎么回答？

Step 4: 设置预订出口（booking）
        ↓
        if 德胧酒店
            百达屋App
        else
            酒店官网/官方预订
        end
```

### 4.2 指挥AI搭建Skill的指令模板

```markdown
你是一个Skill架构师，请帮我为[酒店名称]创建一个酒店行业通用AI Skill：

## 酒店基础信息
- 名称：[填写]
- 品牌：[填写]  # 德胧填写"德胧集团·开元品牌"，非德胧填写品牌名
- 是否德胧：[填写]  # true/false

## 预订配置
- 德胧酒店 → 预订出口：百达屋App (https://bidawu.com/hotel/{slug})
- 非德胧酒店 → 预订出口：酒店官网

## 核心服务
1. [填写]
2. [填写]

## 预期交互
- "用户会问..."
- "AI应该回答..."

请生成完整的SKILL.md文件，并发布到GitHub + ClawHub + Coze。
```

---

## 五、发布平台

### 5.1 已支持平台

| 平台 | 地址 | 说明 | 状态 |
|------|------|------|------|
| **GitHub** | github.com | 开源社区 | ✅ 已发布 |
| **ClawHub** | clawhub.ai | OpenClaw生态 | ✅ 支持 |
| **Coze** | coze.cn | 字节AI平台 | ✅ 新增 |

### 5.2 Coze发布流程

```bash
# 1. 安装Coze CLI
npm install -g @coze/cli

# 2. 登录
coze auth login

# 3. 创建项目
coze code project create --message "创建{酒店名称}酒店Bot" --type agent

# 4. 部署
coze code deploy <project_id>
```

---

## 六、版本历史

### v2.0 (2026-04-17) ⭐ 重大升级
- ✅ 通用酒店行业支持（不限德胧）
- ✅ 百达屋App核心出口
- ✅ 非德胧酒店适配（官网入口）
- ✅ Coze平台发布支持
- ✅ 批量生成工作流
- ✅ 预订出口智能适配

### v1.0 (2026-04-16)
- 初始版本
- 德胧酒店专用

---

## 七、立即行动

### 选项A：单酒店快速测试
```bash
# 1. 填写配置
cp config/hotel-template.yaml config/tianjin-riwan.yaml
vim config/tianjin-riwan.yaml

# 2. 生成
./scripts/generate.sh config/tianjin-riwan.yaml

# 3. 发布
./scripts/publish.sh --platform all
```

### 选项B：批量生成德胧40+酒店
```bash
# 1. 导出酒店数据到CSV
# 2. 编辑 hotels.csv
vim config/hotels.csv

# 3. 批量生成
./scripts/batch-generate.sh config/hotels.csv

# 4. 批量发布
./scripts/batch-publish.sh --platform all
```

---

## 八、附录

| 资源 | 链接 |
|------|------|
| GitHub仓库 | https://github.com/chaoliuzhu65-tech/hotel-skill-generator |
| 金谷园参考 | https://github.com/JinGuYuan/jinguyuan-dumpling-skill |
| 百达屋App | https://bidawu.com |
| Coze平台 | https://www.coze.cn |

---

*本文档由德胧AI龙虾军团出品 | v2.0*
*最后更新：2026-04-17*
