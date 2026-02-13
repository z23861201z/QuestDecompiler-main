# crash_risk_points

## High-Risk Structure Changes

### 1) table -> number
- Not observed in this dataset.

### 2) array -> map
- Not observed as dominant pattern; dominant pattern is table/array nodes becoming missing.

### 3) string-key -> numeric-index
- Not observed as dominant pattern.

### 4) Prototype Flattening / Build-Mode Change
```json
{
  "before": {
    "fileSize": 2231503,
    "constantPoolCount": 24576,
    "prototypeCount": 33,
    "functionCount": 34,
    "instructionCount": 127908,
    "newtableCount": 26514,
    "settableCount": 43144,
    "maxStackDepth": 36,
    "maxFunctionNestingDepth": 1
  },
  "current": {
    "fileSize": 2084563,
    "constantPoolCount": 23864,
    "prototypeCount": 0,
    "functionCount": 1,
    "instructionCount": 114374,
    "newtableCount": 23041,
    "settableCount": 40170,
    "maxStackDepth": 36,
    "maxFunctionNestingDepth": 0
  },
  "deltaPrototype": {
    "before": 33,
    "current": 0,
    "delta": -33,
    "deltaPercent": -100.0
  },
  "deltaFunctionNesting": {
    "before": 1,
    "current": 0,
    "delta": -1,
    "deltaPercent": -100.0
  }
}
```

## Additional High-Risk Findings
- Missing field total: 2741
- Empty-table difference total: 1153
- Most severe missing field: top.npcsay (2602 quests)
- Next severe missing field: top.deleteItem (104 quests)

## Final Required Answers
1. Most likely crash trigger:
- Prototype flattening (33 -> 0) combined with mass removal of expected container fields (`npcsay`, `deleteItem`, partial `goal.*`) causing runtime nil-index access.
2. Main category of issue:
- Primarily field/container loss (including empty-table removal). Order and array-shape deltas are secondary amplifiers.
3. Should Phase4 be rolled back?
- Yes. Current output is structurally non-equivalent and high-risk for client runtime.
4. Should prototype structure be restored?
- Yes. Prototype count and nesting depth collapse indicates structural mismatch at bytecode-function topology level.