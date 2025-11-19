package api

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strings"

	"github.com/maasumiyaat/treeserver/internal/db"
	"github.com/maasumiyaat/treeserver/internal/tree"
	"github.com/maasumiyaat/treeserver/internal/trie"
)

func RegisterHandlers(mux *http.ServeMux) {
	mux.HandleFunc("/avl/insert", handleAVLInsert)
	mux.HandleFunc("/avl/topk", handleAVLTopK)
	mux.HandleFunc("/rbt/topk", handleRBTopK)
	mux.HandleFunc("/trie/autocomplete", handleTrieAutocomplete)
	mux.HandleFunc("/heap/next", handleHeapNext)
	mux.HandleFunc("/kdt/nearby", handleKDNearby)
	mux.HandleFunc("/quadt/visible", handleQuadtVisible)
	mux.HandleFunc("/segment/sum", handleSegmentSum)
	mux.HandleFunc("/merkle/proof", handleMerkleProof)
	mux.HandleFunc("/huff/compress", handleHuffmanCompress)
}

func handleAVLInsert(w http.ResponseWriter, r *http.Request) {
	v := r.URL.Query().Get("v")
	if v == "" {
		http.Error(w, "v required", 400)
		return
	}
	// build AVL from users scores
	rows, err := db.DB.Query("SELECT score FROM users LIMIT 1000")
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	defer rows.Close()
	avl := tree.NewAVL()
	var s int
	for rows.Next() {
		if err := rows.Scan(&s); err == nil {
			avl.Insert(s)
		}
	}
	var vi int
	fmt.Sscanf(v, "%d", &vi)
	avl.Insert(vi)
	json.NewEncoder(w).Encode(map[string]string{"message": "inserted"})
}

func handleAVLTopK(w http.ResponseWriter, r *http.Request) {
	k := 10
	res := tree.MockAVLTopK(db.DB, k)
	json.NewEncoder(w).Encode(res)
}

func handleRBTopK(w http.ResponseWriter, r *http.Request) {
	res := tree.MockRBTopK(db.DB, 10)
	json.NewEncoder(w).Encode(res)
}

func handleTrieAutocomplete(w http.ResponseWriter, r *http.Request) {
	q := r.URL.Query().Get("q")
	if q == "" {
		http.Error(w, "q required", 400)
		return
	}
	rows, err := db.DB.Query("SELECT username FROM users LIMIT 1000")
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	defer rows.Close()
	tr := trie.New()
	var uname string
	for rows.Next() {
		if err := rows.Scan(&uname); err == nil {
			tr.Insert(strings.ToLower(uname))
		}
	}
	res := tr.Prefix(strings.ToLower(q))
	json.NewEncoder(w).Encode(res)
}

func handleHeapNext(w http.ResponseWriter, r *http.Request) {
	rows, err := db.DB.Query("SELECT id, task_name, priority FROM tasks WHERE status = 'pending'")
	if err != nil {
		http.Error(w, err.Error(), 500)
		return
	}
	defer rows.Close()
	var tasks []tree.Task
	for rows.Next() {
		var t tree.Task
		if err := rows.Scan(&t.ID, &t.TaskName, &t.Priority); err == nil {
			tasks = append(tasks, t)
		}
	}
	if len(tasks) == 0 {
		json.NewEncoder(w).Encode(map[string]string{"message": "no tasks"})
		return
	}
	h := tree.TaskHeap(tasks)
	// heap.Init(&h) // not using heap package here, TaskHeap already supports operations in package
	res := tree.PopMin(&h)
	json.NewEncoder(w).Encode(res)
}

func handleKDNearby(w http.ResponseWriter, r *http.Request) {
	qlat := r.URL.Query().Get("lat")
	qlng := r.URL.Query().Get("lng")
	var lat, lng float64
	fmt.Sscanf(qlat, "%f", &lat)
	fmt.Sscanf(qlng, "%f", &lng)
	res := tree.KDNearest(db.DB, lat, lng, 5)
	json.NewEncoder(w).Encode(res)
}

func handleQuadtVisible(w http.ResponseWriter, r *http.Request) {
	// simple wrapper
	x := r.URL.Query().Get("x")
	y := r.URL.Query().Get("y")
	wbox := r.URL.Query().Get("w")
	hbox := r.URL.Query().Get("h")
	var xf, yf, wf, hf float64
	fmt.Sscanf(x, "%f", &xf)
	fmt.Sscanf(y, "%f", &yf)
	fmt.Sscanf(wbox, "%f", &wf)
	fmt.Sscanf(hbox, "%f", &hf)
	res := tree.QuadtreeQuery(db.DB, xf, yf, wf, hf)
	json.NewEncoder(w).Encode(res)
}

func handleSegmentSum(w http.ResponseWriter, r *http.Request) {
	from := r.URL.Query().Get("from")
	to := r.URL.Query().Get("to")
	res := tree.SegmentSum(db.DB, from, to)
	json.NewEncoder(w).Encode(res)
}

func handleMerkleProof(w http.ResponseWriter, r *http.Request) {
	id := r.URL.Query().Get("id")
	root, proof := tree.MerkleProof(db.DB, id)
	json.NewEncoder(w).Encode(map[string]interface{}{"root": root, "proof": proof})
}

func handleHuffmanCompress(w http.ResponseWriter, r *http.Request) {
	var body struct {
		Text string `json:"text"`
	}
	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		http.Error(w, "invalid json", 400)
		return
	}
	codes, enc := tree.HuffmanCompress(body.Text)
	json.NewEncoder(w).Encode(map[string]interface{}{"codes": codes, "encoded": enc})
}
