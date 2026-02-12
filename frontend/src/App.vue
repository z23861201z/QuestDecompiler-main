<template>
  <div class="layout" :style="themeVars">
    <div class="bg-mask"></div>

    <header class="topbar">
      <div class="title">Quest 后台管理系统</div>
      <div class="actions">
        <button class="theme-btn" @click="toggleTheme">切换主题色</button>
      </div>
    </header>

    <aside class="sidebar">
      <div class="menu-group">
        <div class="menu-title">任务管理</div>
        <button class="submenu" :class="{active: view==='quest-template'}" @click="view='quest-template'">主任务模板</button>
        <button class="submenu" :class="{active: view==='npc-template'}" @click="view='npc-template'">NPC文本模板</button>
        <button class="submenu" :class="{active: view==='account-task'}" @click="view='account-task'">账号任务管理</button>
      </div>

      <div class="menu-group"><div class="menu-title">角色管理</div></div>
      <div class="menu-group"><div class="menu-title">物品管理</div></div>
      <div class="menu-group"><div class="menu-title">地图管理</div></div>
      <div class="menu-group"><div class="menu-title">时装管理</div></div>
      <div class="menu-group"><div class="menu-title">日志管理</div></div>
    </aside>

    <main class="content">
      <section class="panel dashboard">
        <h3>Dashboard</h3>
        <div class="dash-grid">
          <div class="metric"><span>任务数量</span><b>{{ dashboard.questCount }}</b></div>
          <div class="metric"><span>NPC数量</span><b>{{ dashboard.npcCount }}</b></div>
          <div class="metric"><span>最近导出</span><b>{{ dashboard.recentExportReports.length }}</b></div>
          <div class="metric"><span>物品数据量</span><b>{{ dashboard.itemCount }}</b></div>
          <div class="metric"><span>地图关联量</span><b>{{ dashboard.mapCount }}</b></div>
          <div class="metric"><span>时装关联量</span><b>{{ dashboard.fashionCount }}</b></div>
        </div>
      </section>

      <section v-if="view==='quest-template'" class="panel">
        <h3>主任务模板</h3>
        <div class="toolbar">
          <input v-model="questKeyword" placeholder="搜索 questId / name" />
          <button @click="reloadQuestPage(1)">查询</button>
        </div>

        <div class="grid-two">
          <div>
            <table>
              <thead>
                <tr>
                  <th>questId</th>
                  <th>任务名称</th>
                  <th>等级</th>
                  <th>奖励EXP</th>
                  <th>奖励金币</th>
                  <th>最近修改时间</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="row in questPage.records" :key="row.questId" :class="{active: selectedQuestId===row.questId}" @click="selectQuest(row.questId)">
                  <td>{{ row.questId }}</td>
                  <td>{{ row.name }}</td>
                  <td>{{ row.needLevel }}</td>
                  <td>{{ row.rewardExp }}</td>
                  <td>{{ row.rewardGold }}</td>
                  <td>{{ row.recentModifiedAt }}</td>
                </tr>
              </tbody>
            </table>

            <div class="pager">
              <button :disabled="questPage.page<=1" @click="reloadQuestPage(questPage.page-1)">上一页</button>
              <span>第 {{ questPage.page }} 页 / 共 {{ questTotalPages }} 页（{{ questPage.total }} 条）</span>
              <button :disabled="questPage.page>=questTotalPages" @click="reloadQuestPage(questPage.page+1)">下一页</button>
            </div>
          </div>

          <div v-if="questDetail" class="editor">
            <label>任务名称</label>
            <input v-model="questDetail.name" />

            <label>任务内容（每行一条）</label>
            <textarea rows="6" v-model="questContentsText"></textarea>

            <label>任务要求（answer，每行一条）</label>
            <textarea rows="4" v-model="questAnswerText"></textarea>

            <label>任务奖励说明（info，每行一条）</label>
            <textarea rows="4" v-model="questInfoText"></textarea>

            <button @click="saveQuestDetail">保存修改</button>
          </div>
        </div>
      </section>

      <section v-if="view==='npc-template'" class="panel">
        <h3>NPC文本模板</h3>
        <div class="toolbar">
          <input v-model="npcFilter.questId" placeholder="关联 questId" />
          <input v-model="npcFilter.npcFile" placeholder="npc_xxxx.lua" />
          <input v-model="npcFilter.keyword" placeholder="关键字" />
          <button @click="reloadNpcPage(1)">查询</button>
        </div>

        <table>
          <thead>
            <tr>
              <th>textId</th>
              <th>npcFile</th>
              <th>line</th>
              <th>callType</th>
              <th>关联任务数</th>
              <th>最近修改时间</th>
              <th>原文</th>
              <th>修改文本</th>
              <th>操作</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="row in npcPage.records" :key="row.textId">
              <td>{{ row.textId }}</td>
              <td>{{ row.npcFile }}</td>
              <td>{{ row.line }}</td>
              <td>{{ row.callType }}</td>
              <td>{{ row.linkedQuestCount }}</td>
              <td>{{ row.recentModifiedAt }}</td>
              <td class="long-text">{{ row.rawText }}</td>
              <td><input v-model="row.modifiedText" /></td>
              <td><button @click="saveNpcRow(row)">保存</button></td>
            </tr>
          </tbody>
        </table>

        <div class="pager">
          <button :disabled="npcPage.page<=1" @click="reloadNpcPage(npcPage.page-1)">上一页</button>
          <span>第 {{ npcPage.page }} 页 / 共 {{ npcTotalPages }} 页（{{ npcPage.total }} 条）</span>
          <button :disabled="npcPage.page>=npcTotalPages" @click="reloadNpcPage(npcPage.page+1)">下一页</button>
        </div>
      </section>

      <section v-if="view==='account-task'" class="panel">
        <h3>账号任务管理</h3>
        <p>该模块先预留，暂不对接后端功能。</p>
      </section>

      <section class="panel">
        <h3>导出中心</h3>
        <button @click="exportAll" :disabled="exporting">一键导出 luc</button>
        <span class="muted" v-if="exportReport">耗时 {{ exportReport.elapsedMs }} ms，导出文件 {{ exportReport.npcExportFileCount + exportReport.questExportFileCount }} 个</span>
      </section>
    </main>

    <div class="toast-stack">
      <div class="toast" v-for="item in toasts" :key="item.id">{{ item.text }}</div>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, ref } from 'vue'
import {
  getDashboard,
  getNpcTexts,
  getQuestDetail,
  getQuestList,
  runExport,
  saveNpcText,
  saveQuest
} from './api'

const themes = [
  { name: 'blue', primary: '#1f6fe5', accent: '#4f8ef8' },
  { name: 'cyan', primary: '#0f7ea9', accent: '#31a7d8' },
  { name: 'purple', primary: '#5d63d4', accent: '#8086eb' }
]
const themeIndex = ref(0)
const themeVars = computed(() => ({
  '--primary': themes[themeIndex.value].primary,
  '--accent': themes[themeIndex.value].accent,
  '--bg-image': 'url(https://imgsa.baidu.com/forum/pic/item/e91a80eef01f3a29f87ea8f79825bc315c607c27.jpg)'
}))

const view = ref('quest-template')
const dashboard = ref({ questCount: 0, npcCount: 0, recentExportReports: [], itemCount: 0, mapCount: 0, fashionCount: 0 })

const questKeyword = ref('')
const questPage = ref({ page: 1, pageSize: 20, total: 0, records: [] })
const questTotalPages = computed(() => Math.max(1, Math.ceil((questPage.value.total || 0) / questPage.value.pageSize)))
const selectedQuestId = ref(null)
const questDetail = ref(null)
const questContentsText = ref('')
const questAnswerText = ref('')
const questInfoText = ref('')

const npcFilter = ref({ questId: '', npcFile: '', keyword: '' })
const npcPage = ref({ page: 1, pageSize: 20, total: 0, records: [] })
const npcTotalPages = computed(() => Math.max(1, Math.ceil((npcPage.value.total || 0) / npcPage.value.pageSize)))

const exporting = ref(false)
const exportReport = ref(null)

const toasts = ref([])

function toggleTheme() {
  themeIndex.value = (themeIndex.value + 1) % themes.length
}

function pushToast(text) {
  const id = Date.now() + Math.random()
  toasts.value.push({ id, text })
  setTimeout(() => {
    toasts.value = toasts.value.filter(t => t.id !== id)
  }, 2600)
}

async function loadDashboard() {
  dashboard.value = await getDashboard()
}

async function reloadQuestPage(page = 1) {
  questPage.value = await getQuestList(questKeyword.value, page, questPage.value.pageSize || 20)
}

async function selectQuest(questId) {
  selectedQuestId.value = questId
  const detail = await getQuestDetail(questId)
  questDetail.value = detail
  questContentsText.value = (detail.contents || []).join('\n')
  questAnswerText.value = (detail.answer || []).join('\n')
  questInfoText.value = (detail.info || []).join('\n')
}

async function saveQuestDetail() {
  if (!selectedQuestId.value || !questDetail.value) return
  const payload = {
    name: questDetail.value.name,
    contents: splitLines(questContentsText.value),
    answer: splitLines(questAnswerText.value),
    info: splitLines(questInfoText.value)
  }
  const result = await saveQuest(selectedQuestId.value, payload)
  if (result.status === 'SUCCESS') {
    pushToast(`任务保存成功（changedRows=${result.artifacts?.changedRows || 0}）`)
    await reloadQuestPage(questPage.value.page)
  } else {
    pushToast(`任务保存失败：${result.error?.message || 'unknown'}`)
  }
}

async function reloadNpcPage(page = 1) {
  const params = {
    questId: npcFilter.value.questId ? Number(npcFilter.value.questId) : undefined,
    npcFile: npcFilter.value.npcFile || undefined,
    keyword: npcFilter.value.keyword || undefined,
    page,
    pageSize: npcPage.value.pageSize || 20
  }
  npcPage.value = await getNpcTexts(params)
}

async function saveNpcRow(row) {
  const result = await saveNpcText(row.textId, { modifiedText: row.modifiedText })
  if (result.status === 'SUCCESS') {
    pushToast(`NPC文本保存成功（textId=${row.textId}）`)
    await reloadNpcPage(npcPage.value.page)
  } else {
    pushToast(`NPC保存失败：${result.error?.message || 'unknown'}`)
  }
}

async function exportAll() {
  exporting.value = true
  try {
    exportReport.value = await runExport()
    if (exportReport.value.finalStatus === 'SAFE') {
      pushToast(`导出成功，耗时 ${exportReport.value.elapsedMs} ms`)
    } else {
      pushToast(`导出失败：${exportReport.value.note || 'unknown'}`)
    }
    await loadDashboard()
  } catch (e) {
    pushToast(`导出异常：${e?.message || e}`)
  } finally {
    exporting.value = false
  }
}

function splitLines(text) {
  if (!text) return []
  return text.split('\n').map(v => v.trim()).filter(Boolean)
}

onMounted(async () => {
  await loadDashboard()
  await reloadQuestPage(1)
  await reloadNpcPage(1)
})
</script>

