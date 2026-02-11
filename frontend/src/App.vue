<template>
  <div class="page">
    <h1>Quest Web Admin (Phase-D)</h1>

    <section class="card">
      <h2>Dashboard</h2>
      <div class="grid3">
        <div>Quest 数量: <b>{{ dashboard.questCount }}</b></div>
        <div>NPC 数量: <b>{{ dashboard.npcCount }}</b></div>
        <div>最近导出: <b>{{ dashboard.recentExportReports.length }}</b></div>
      </div>
      <ul>
        <li v-for="item in dashboard.recentExportReports" :key="item">{{ item }}</li>
      </ul>
    </section>

    <section class="card">
      <h2>Quest 管理</h2>
      <div class="row">
        <input v-model="questKeyword" placeholder="搜索 questId 或 name" />
        <button @click="loadQuestList">查询</button>
      </div>
      <div class="split">
        <div>
          <table>
            <thead>
              <tr><th>questId</th><th>name</th><th>needLevel</th></tr>
            </thead>
            <tbody>
              <tr v-for="q in questList" :key="q.questId" @click="selectQuest(q.questId)" :class="{ active: selectedQuestId === q.questId }">
                <td>{{ q.questId }}</td>
                <td>{{ q.name }}</td>
                <td>{{ q.needLevel }}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <div v-if="questDetail">
          <label>任务名</label>
          <input v-model="questDetail.name" />

          <label>contents（每行一条）</label>
          <textarea v-model="questContentsText" rows="6"></textarea>

          <label>answer（每行一条）</label>
          <textarea v-model="questAnswerText" rows="4"></textarea>

          <label>info（每行一条）</label>
          <textarea v-model="questInfoText" rows="4"></textarea>

          <button @click="saveQuestDetail" :disabled="!selectedQuestId">保存 Quest</button>
          <span class="msg">{{ questMsg }}</span>
        </div>
      </div>
    </section>

    <section class="card">
      <h2>NPC 文本管理</h2>
      <div class="row">
        <input v-model="npcFilter.questId" placeholder="关联 questId" />
        <input v-model="npcFilter.npcFile" placeholder="npc_XXXX.lua" />
        <input v-model="npcFilter.keyword" placeholder="关键字" />
        <button @click="loadNpcTexts">查询</button>
      </div>
      <table>
        <thead>
          <tr>
            <th>textId</th><th>npcFile</th><th>line</th><th>callType</th><th>rawText</th><th>modifiedText</th><th>操作</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="row in npcTexts" :key="row.textId">
            <td>{{ row.textId }}</td>
            <td>{{ row.npcFile }}</td>
            <td>{{ row.line }}</td>
            <td>{{ row.callType }}</td>
            <td class="textcol">{{ row.rawText }}</td>
            <td>
              <input v-model="row.modifiedText" />
            </td>
            <td>
              <button @click="saveNpcRow(row)">保存</button>
            </td>
          </tr>
        </tbody>
      </table>
      <span class="msg">{{ npcMsg }}</span>
    </section>

    <section class="card">
      <h2>导出中心</h2>
      <button @click="exportAll" :disabled="exporting">一键导出</button>
      <span class="msg">{{ exportMsg }}</span>
      <div v-if="exportReport">
        <p>finalStatus: <b>{{ exportReport.finalStatus }}</b></p>
        <p>elapsedMs: <b>{{ exportReport.elapsedMs }}</b></p>
        <p>quest 导出文件数: <b>{{ exportReport.questExportFileCount }}</b></p>
        <p>npc 导出文件数: <b>{{ exportReport.npcExportFileCount }}</b></p>
        <p>DB变更: <b>{{ exportReport.dbChanged }}</b></p>
        <p>导出时间戳变化: <b>{{ exportReport.exportTimestampChanged }}</b></p>
        <pre>{{ exportReport.artifacts }}</pre>
      </div>
    </section>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import {
  getDashboard,
  getNpcTexts,
  getQuestDetail,
  getQuestList,
  runExport,
  saveNpcText,
  saveQuest
} from './api'

const dashboard = ref({ questCount: 0, npcCount: 0, recentExportReports: [] })
const questKeyword = ref('')
const questList = ref([])
const selectedQuestId = ref(null)
const questDetail = ref(null)
const questContentsText = ref('')
const questAnswerText = ref('')
const questInfoText = ref('')
const questMsg = ref('')

const npcFilter = ref({ questId: '', npcFile: '', keyword: '' })
const npcTexts = ref([])
const npcMsg = ref('')

const exporting = ref(false)
const exportMsg = ref('')
const exportReport = ref(null)

async function loadDashboard() {
  dashboard.value = await getDashboard()
}

async function loadQuestList() {
  questList.value = await getQuestList(questKeyword.value, 100)
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
  questMsg.value = `${result.status} changedRows=${result.artifacts?.changedRows || 0}`
}

async function loadNpcTexts() {
  const params = {
    questId: npcFilter.value.questId ? Number(npcFilter.value.questId) : undefined,
    npcFile: npcFilter.value.npcFile || undefined,
    keyword: npcFilter.value.keyword || undefined,
    limit: 200
  }
  npcTexts.value = await getNpcTexts(params)
}

async function saveNpcRow(row) {
  const result = await saveNpcText(row.textId, { modifiedText: row.modifiedText })
  npcMsg.value = `textId=${row.textId} ${result.status} changedRows=${result.artifacts?.changedRows || 0}`
}

async function exportAll() {
  exporting.value = true
  exportMsg.value = '导出中...'
  try {
    exportReport.value = await runExport()
    exportMsg.value = `${exportReport.value.finalStatus} elapsedMs=${exportReport.value.elapsedMs}`
    await loadDashboard()
  } catch (e) {
    exportMsg.value = `FAILED: ${e?.message || e}`
  } finally {
    exporting.value = false
  }
}

function splitLines(text) {
  if (!text) return []
  return text
    .split('\n')
    .map(v => v.trim())
    .filter(v => v.length > 0)
}

onMounted(async () => {
  await loadDashboard()
  await loadQuestList()
  await loadNpcTexts()
})
</script>

