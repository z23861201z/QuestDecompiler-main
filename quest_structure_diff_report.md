# quest_structure_diff_report

## Input
- Original LUC: `D:/TitanGames/GhostOnline/zChina/Script/quest_before_db_export_20260213_110051.luc`
- Current LUC: `D:/TitanGames/GhostOnline/zChina/Script/quest.luc`
- Decompiled original Lua: `reports/phase4_crash_selfcheck/quest_before_db_export_20260213_110051.raw.lua`
- Decompiled current Lua: `reports/phase4_crash_selfcheck/quest_current.raw.lua`

## Global Diff Summary
```json
{
  "questMissingInCurrentCount": 0,
  "questAddedInCurrentCount": 0,
  "missingFieldCount": 2741,
  "addedFieldCount": 0,
  "fieldOrderChangeCount": 2631,
  "arrayOrderChangeCount": 3230,
  "rewardGetItemKeyChangeCount": 0,
  "moneyGoldKeyChangeCount": 0,
  "goalRewardSwapCount": 13,
  "emptyTableDifferenceCount": 1153,
  "nilVsZeroDifferenceCount": 244,
  "typeChangeCount": 8450,
  "missingFieldTop": [
    {
      "fieldPath": "top.npcsay",
      "count": 2602
    },
    {
      "fieldPath": "top.deleteItem",
      "count": 104
    },
    {
      "fieldPath": "goal.fame",
      "count": 14
    },
    {
      "fieldPath": "top.needQuest",
      "count": 5
    },
    {
      "fieldPath": "goal.killMonster",
      "count": 5
    },
    {
      "fieldPath": "goal.timeOut",
      "count": 5
    },
    {
      "fieldPath": "goal.getitem",
      "count": 2
    },
    {
      "fieldPath": "reward.getitem",
      "count": 2
    },
    {
      "fieldPath": "goal.meetNPC",
      "count": 1
    },
    {
      "fieldPath": "goal.exp",
      "count": 1
    }
  ],
  "addedFieldTop": []
}
```

## Missing Fields (present before, missing now)
```json
[
  {
    "fieldPath": "top.npcsay",
    "count": 2602
  },
  {
    "fieldPath": "top.deleteItem",
    "count": 104
  },
  {
    "fieldPath": "goal.fame",
    "count": 14
  },
  {
    "fieldPath": "top.needQuest",
    "count": 5
  },
  {
    "fieldPath": "goal.killMonster",
    "count": 5
  },
  {
    "fieldPath": "goal.timeOut",
    "count": 5
  },
  {
    "fieldPath": "goal.getitem",
    "count": 2
  },
  {
    "fieldPath": "reward.getitem",
    "count": 2
  },
  {
    "fieldPath": "goal.meetNPC",
    "count": 1
  },
  {
    "fieldPath": "goal.exp",
    "count": 1
  }
]
```
Evidence samples:
```json
[
  {
    "questId": 2,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 3,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 4,
    "scope": "top",
    "field": "needQuest"
  },
  {
    "questId": 4,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 5,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 6,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 7,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 8,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 9,
    "scope": "top",
    "field": "needQuest"
  },
  {
    "questId": 9,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 10,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 11,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 12,
    "scope": "top",
    "field": "needQuest"
  },
  {
    "questId": 12,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 13,
    "scope": "top",
    "field": "deleteItem"
  },
  {
    "questId": 13,
    "scope": "top",
    "field": "needQuest"
  },
  {
    "questId": 13,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 14,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 15,
    "scope": "top",
    "field": "npcsay"
  },
  {
    "questId": 16,
    "scope": "top",
    "field": "npcsay"
  }
]
```

## Added Fields
```json
[]
```

## Field Order Changes
```json
[
  {
    "questId": 2,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 3,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "requstItem",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "requstItem",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 4,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "needQuest",
      "requstItem",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "requstItem",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 5,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 6,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 7,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 8,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 9,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "needQuest",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 10,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 11,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 12,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "needQuest",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 13,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "needItem",
      "needQuest",
      "deleteItem",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "needItem",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 14,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 15,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  },
  {
    "questId": 16,
    "scope": "top",
    "before": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "npcsay",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ],
    "current": [
      "id",
      "name",
      "contents",
      "answer",
      "info",
      "bQLoop",
      "needLevel",
      "goal",
      "reward"
    ]
  }
]
```

## reward/getItem Key Changes
- No reward key rename between `getItem` and `items` detected.

## money vs gold Key Changes
- No key rename between `money` and `gold` detected.

## goal/reward Swap Cases
```json
[
  {
    "questId": 169,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 172,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 175,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 178,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 181,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 184,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 385,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 388,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 635,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 638,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 1418,
    "movedToReward": [
      "exp",
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 2092,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  },
  {
    "questId": 2095,
    "movedToReward": [
      "fame"
    ],
    "movedToGoal": []
  }
]
```

## Empty Table Output Differences
```json
[
  {
    "questId": 2,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 3,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 4,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 5,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 6,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 7,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 8,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 9,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 10,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 11,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 12,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 13,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 14,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 15,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 16,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 17,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 18,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 19,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 20,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  },
  {
    "questId": 21,
    "removedEmptyTables": [
      "npcsay"
    ],
    "addedEmptyTables": []
  }
]
```

## nil vs 0 Differences
```json
[
  {
    "questId": 3,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 3,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 4,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 4,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 52,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 52,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 53,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 53,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 59,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 59,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 70,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 70,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 71,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 71,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 75,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 75,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 77,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 77,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  },
  {
    "questId": 87,
    "path": "requstItem.meetcnt",
    "before": {
      "type": "missing"
    },
    "current": {
      "type": "number",
      "value": 0
    }
  },
  {
    "questId": 87,
    "path": "requstItem[1].meetcnt",
    "before": {
      "type": "number",
      "value": 0
    },
    "current": {
      "type": "missing"
    }
  }
]
```

## Other Concrete Differences
Array order change samples:
```json
[
  {
    "questId": 3,
    "path": "requstItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990002,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 4,
    "path": "requstItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990003,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 13,
    "path": "deleteItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990004,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 15,
    "path": "answer",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": [
      {
        "type": "string"
      }
    ]
  },
  {
    "questId": 17,
    "path": "answer",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": [
      {
        "type": "string"
      }
    ]
  },
  {
    "questId": 18,
    "path": "answer",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": [
      {
        "type": "string"
      }
    ]
  },
  {
    "questId": 20,
    "path": "answer",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": [
      {
        "type": "string"
      }
    ]
  },
  {
    "questId": 43,
    "path": "npcsay",
    "before": [
      {
        "type": "string"
      }
    ],
    "current": null
  },
  {
    "questId": 44,
    "path": "reward.getSkill",
    "before": [
      {
        "type": "number",
        "value": 10304
      }
    ],
    "current": [
      {
        "type": "number",
        "value": 10305
      }
    ]
  },
  {
    "questId": 52,
    "path": "deleteItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990012,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      },
      {
        "type": "pairTable",
        "id": 8990012,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      },
      {
        "type": "pairTable",
        "id": 8990012,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      },
      {
        "type": "pairTable",
        "id": 8990012,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 52,
    "path": "requstItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990012,
        "count": 4,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 53,
    "path": "deleteItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990013,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 53,
    "path": "npcsay",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": null
  },
  {
    "questId": 53,
    "path": "requstItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990013,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 56,
    "path": "deleteItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8910321,
        "count": 10,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 56,
    "path": "npcsay",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": null
  },
  {
    "questId": 59,
    "path": "requstItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990018,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 60,
    "path": "deleteItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8910421,
        "count": 15,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  },
  {
    "questId": 60,
    "path": "npcsay",
    "before": [
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      },
      {
        "type": "string"
      }
    ],
    "current": null
  },
  {
    "questId": 60,
    "path": "requstItem",
    "before": [
      {
        "type": "pairTable",
        "id": 8990019,
        "count": 1,
        "fieldOrder": [
          "meetcnt",
          "itemid",
          "itemcnt"
        ]
      }
    ],
    "current": null
  }
]
```