#!/bin/bash
set -e

# based on: https://github.com/kythe/kythe/blob/5379c81/tools/cpp/generate_compilation_database.sh

JSON_OUT="$(pwd)/compile_commands.json"
BAZEL_ROOT="$(bazel info execution_root 2>/dev/null)"
echo "Generating compile_commands.json..."
find "$BAZEL_ROOT" -name '*.compile_command.json' -print0 | while read -r -d '' fname; do
    sed -e "s|@BAZEL_ROOT@|$BAZEL_ROOT|g" < "$fname" >> $JSON_OUT
    echo "" >> $JSON_OUT
done

# Decompose, insert and keep the most recent entry for a given file, then
# recombine.
sed 's/\(^[[]\)\|\([],]$\)//;/^$/d;' < $JSON_OUT \
    | tac | sort -u -t, -k1,1 \
    | sed '1s/^./[\0/;s/}$/},/;$s/,$/]/' > $JSON_OUT.tmp
mv $JSON_OUT{.tmp,}
sed -e 's/ -fno-canonical-system-headers//g' -i $JSON_OUT
echo "Done!"
