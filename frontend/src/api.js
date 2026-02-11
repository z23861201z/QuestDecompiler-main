import axios from 'axios'

const http = axios.create({
  baseURL: '/api',
  timeout: 120000
})

export function getDashboard() {
  return http.get('/admin/dashboard').then(r => r.data)
}

export function getQuestList(keyword = '', limit = 100) {
  return http.get('/admin/quests', { params: { keyword, limit } }).then(r => r.data)
}

export function getQuestDetail(questId) {
  return http.get(`/admin/quests/${questId}`).then(r => r.data)
}

export function saveQuest(questId, payload) {
  return http.post(`/admin/quests/${questId}/save`, payload).then(r => r.data)
}

export function getNpcTexts(params = {}) {
  return http.get('/admin/npc-texts', { params }).then(r => r.data)
}

export function saveNpcText(textId, payload) {
  return http.post(`/admin/npc-texts/${textId}/save`, payload).then(r => r.data)
}

export function runExport() {
  return http.post('/admin/export/run', {}).then(r => r.data)
}

