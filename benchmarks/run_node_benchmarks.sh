#!/usr/bin/env bash
LABEL=${1:-vanilla}
NODE_DIR=$2  # Path to node-vanilla or node-hardened
OUTDIR=$PWD/results/$LABEL
mkdir -p "$OUTDIR"
NODE_BIN="$NODE_DIR/out/bin/node"
if [ "$LABEL" = "hardened" ]; then
  NODE_BIN="$NODE_BIN --seccomp-bpf=$NODE_DIR/out/seccomp/node_seccomp.json"
fi
echo "Running Node.js/V8 benchmarks..."
$NODE_BIN --version > "$OUTDIR/node_version.txt"
$NODE_BIN benchmark/common.js > "$OUTDIR/common.txt" 2>&1
$NODE_BIN benchmark/crypto.js aes256-ctr > "$OUTDIR/crypto.txt" 2>&1
if [ ! -d octane ]; then
  git clone https://github.com/chromium/octane.git
fi
cd octane
for i in {1..5}; do
  $NODE_BIN run.js > "$OUTDIR/octane_run_$i.txt" 2>&1
done
cd ..
cat > fork_bench.js <<'EOF'
const { spawnSync } = require('child_process');
const iterations = 1000;
console.time('fork-exec');
for (let i = 0; i < iterations; i++) {
  spawnSync('true', [], { stdio: 'ignore' });
}
console.timeEnd('fork-exec');
EOF
for i in {1..5}; do
  $NODE_BIN fork_bench.js > "$OUTDIR/fork_run_$i.txt" 2>&1
done
echo "Done → $OUTDIR"