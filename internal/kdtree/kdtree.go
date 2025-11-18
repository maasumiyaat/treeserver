package tree

import (
    "database/sql"
    "sort"
    "math"
)

type Point struct { Name string; Lat, Lng float64 }

func KDNearest(db *sql.DB, lat, lng float64, k int) []map[string]interface{} {
    rows, err := db.Query("SELECT name, latitude, longitude FROM datacenters")
    if err != nil { return nil }
    defer rows.Close()
    var pts []Point
    for rows.Next() {
        var p Point
        if err := rows.Scan(&p.Name, &p.Lat, &p.Lng); err == nil { pts = append(pts, p) }
    }
    sort.Slice(pts, func(i,j int) bool { return pts[i].Lat < pts[j].Lat })
    type Res struct{ Name string; Dist float64 }
    var res []Res
    for _, p := range pts {
        d := haversine(lat, lng, p.Lat, p.Lng)
        res = append(res, Res{p.Name, d})
    }
    sort.Slice(res, func(i,j int) bool { return res[i].Dist < res[j].Dist })
    if len(res) > k { res = res[:k] }
    out := []map[string]interface{}{}
    for _, r := range res { out = append(out, map[string]interface{}{"name":r.Name,"dist":r.Dist}) }
    return out
}

func haversine(lat1, lon1, lat2, lon2 float64) float64 {
    const R = 6371.0
    φ1 := lat1 * math.Pi / 180
    φ2 := lat2 * math.Pi / 180
    Δφ := (lat2 - lat1) * math.Pi / 180
    Δλ := (lon2 - lon1) * math.Pi / 180
    a := math.Sin(Δφ/2)*math.Sin(Δφ/2) + math.Cos(φ1)*math.Cos(φ2)*math.Sin(Δλ/2)*math.Sin(Δλ/2)
    c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))
    return R * c
}
