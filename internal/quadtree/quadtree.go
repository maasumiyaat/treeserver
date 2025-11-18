package tree

import (
    "database/sql"
)

type MapObject struct { ID string; Type string; X, Y float64; Meta string }

func QuadtreeQuery(db *sql.DB, x, y, w, h float64) []MapObject {
    minx := x; miny := y; maxx := x+w; maxy := y+h
    rows, err := db.Query("SELECT id, object_type, x, y, metadata FROM map_objects")
    if err != nil { return nil }
    defer rows.Close()
    var res []MapObject
    for rows.Next() {
        var mo MapObject
        if err := rows.Scan(&mo.ID, &mo.Type, &mo.X, &mo.Y, &mo.Meta); err == nil {
            if mo.X >= minx && mo.X <= maxx && mo.Y >= miny && mo.Y <= maxy { res = append(res, mo) }
        }
    }
    return res
}
