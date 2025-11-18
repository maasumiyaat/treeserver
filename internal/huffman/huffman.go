package tree

import "sort"

func HuffmanCompress(s string) (map[rune]string, string) {
    freq := map[rune]int{}
    for _, r := range s { freq[r]++ }
    type kv struct{ r rune; f int }
    var arr []kv
    for r,f := range freq { arr = append(arr, kv{r,f}) }
    sort.Slice(arr, func(i,j int) bool { return arr[i].f < arr[j].f })
    codes := map[rune]string{}
    for i,kv := range arr { codes[kv.r] = fmtCode(i+1) }
    var out string
    for _, ch := range s { out += codes[ch] }
    return codes, out
}

func fmtCode(n int) string { return fmt.Sprintf("%b", n) }
