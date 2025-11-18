package tree

import (
    "database/sql"
    "time"
)

func SegmentSum(db *sql.DB, fromStr, toStr string) map[string]int {
    from, _ := time.Parse(time.RFC3339, fromStr)
    to, _ := time.Parse(time.RFC3339, toStr)
    rows, err := db.Query("SELECT timestamp, calls FROM api_usage WHERE timestamp >= $1 AND timestamp <= $2 ORDER BY timestamp", from, to)
    if err != nil { return map[string]int{"sum":0} }
    defer rows.Close()
    total := 0
    for rows.Next() {
        var ts time.Time; var c int
        if err := rows.Scan(&ts, &c); err == nil { total += c }
    }
    return map[string]int{"sum": total}
}
