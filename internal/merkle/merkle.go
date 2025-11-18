package tree

import (
    "crypto/sha256"
    "database/sql"
    "encoding/base64"
)

func MerkleProof(db *sql.DB, id string) (string, []string) {
    rows, err := db.Query("SELECT id, log_message FROM logs ORDER BY created_at")
    if err != nil { return "", nil }
    defer rows.Close()
    var leaves [][]byte
    var ids []string
    for rows.Next() {
        var lid, msg string
        if err := rows.Scan(&lid, &msg); err == nil {
            h := sha256.Sum256([]byte(msg))
            leaves = append(leaves, h[:])
            ids = append(ids, lid)
        }
    }
    if len(leaves) == 0 { return "", nil }
    root := buildMerkleRoot(leaves)
    index := -1
    for i, v := range ids { if v == id { index = i; break } }
    if index == -1 { return "", nil }
    proof := buildMerkleProof(leaves, index)
    return base64.StdEncoding.EncodeToString(root), proof
}

func buildMerkleRoot(leaves [][]byte) []byte {
    if len(leaves) == 0 { return nil }
    cur := leaves
    for len(cur) > 1 {
        var next [][]byte
        for i := 0; i < len(cur); i += 2 {
            if i+1 == len(cur) { next = append(next, sha256Sum(append(cur[i], cur[i]...))) }
            else { next = append(next, sha256Sum(append(cur[i], cur[i+1]...))) }
        }
        cur = next
    }
    return cur[0]
}

func buildMerkleProof(leaves [][]byte, idx int) []string {
    proof := []string{}
    size := len(leaves)
    layer := leaves
    for size > 1 {
        var next [][]byte
        for i := 0; i < size; i += 2 {
            if i+1 == size {
                next = append(next, sha256Sum(append(layer[i], layer[i]...)))
                if i == idx { proof = append(proof, base64.StdEncoding.EncodeToString(layer[i])) }
            } else {
                next = append(next, sha256Sum(append(layer[i], layer[i+1]...)))
                if i == idx { proof = append(proof, base64.StdEncoding.EncodeToString(layer[i+1])) }
                if i+1 == idx { proof = append(proof, base64.StdEncoding.EncodeToString(layer[i])) }
            }
        }
        idx = idx / 2
        layer = next
        size = len(layer)
    }
    return proof
}

func sha256Sum(data []byte) []byte { h := sha256.Sum256(data); return h[:] }
