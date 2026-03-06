#!/usr/bin/env bash
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
JAVA_DIR="$SCRIPT_DIR/java"
WORK_DIR="/tmp/exam_grading_$$"

# Counters for summary
total_students=0
compile_ok=0
compile_fail=0
countWords_found=0
countWords_pass=0
countChars_found=0
countChars_pass=0
longestWord_found=0
longestWord_pass=0
countOcc_found=0
countOcc_pass=0
main_found=0

# Pre-compile TestHarness
echo "=== Compiling TestHarness ==="
HARNESS_DIR="$WORK_DIR/_harness"
mkdir -p "$HARNESS_DIR"
cp "$SCRIPT_DIR/TestHarness.java" "$HARNESS_DIR/"
if ! javac "$HARNESS_DIR/TestHarness.java" 2>/dev/null; then
    echo "FATAL: TestHarness.java failed to compile"
    exit 1
fi
HARNESS_CLASS="$HARNESS_DIR/TestHarness.class"
echo "TestHarness compiled OK"
echo ""

# Discover students: group files by first backslash-delimited segment
declare -A student_names
declare -A student_files

for file in "$JAVA_DIR"/*; do
    basename="$(basename "$file")"
    # Extract student ID (first \-delimited segment)
    student_id="${basename%%\\*}"
    # Extract student name (second \-delimited segment)
    rest="${basename#*\\}"
    student_name="${rest%%\\*}"
    # Extract just the java filename (last \-delimited segment)
    java_file="${basename##*\\}"

    student_names["$student_id"]="$student_name"
    # Append to file list
    if [[ -v student_files["$student_id"] ]]; then
        student_files["$student_id"]+=$'\n'"$file|$java_file"
    else
        student_files["$student_id"]="$file|$java_file"
    fi
done

# Sort student IDs
mapfile -t sorted_ids < <(printf '%s\n' "${!student_files[@]}" | sort)

for student_id in "${sorted_ids[@]}"; do
    total_students=$((total_students + 1))
    student_name="${student_names[$student_id]}"
    echo "=== $student_id ($student_name) ==="

    # Create temp dir
    student_dir="$WORK_DIR/$student_id"
    mkdir -p "$student_dir"

    # Copy Java files
    while IFS='|' read -r src_path java_file; do
        cp "$src_path" "$student_dir/$java_file"
    done <<< "${student_files[$student_id]}"

    # Compile
    if (cd "$student_dir" && javac -Xlint:none *.java 2>"$student_dir/compile.log"); then
        echo "COMPILE=OK"
        compile_ok=$((compile_ok + 1))

        # Copy pre-compiled TestHarness
        cp "$HARNESS_CLASS" "$student_dir/"
        # Also copy any inner classes
        find "$HARNESS_DIR" -name 'TestHarness$*.class' -exec cp {} "$student_dir/" \; 2>/dev/null || true

        # Run tests with timeout
        output=$(cd "$student_dir" && timeout 30 java -cp . TestHarness 2>/dev/null) || true
        echo "$output"

        # Parse output for summary
        if echo "$output" | grep -q "^countWords: FOUND"; then
            countWords_found=$((countWords_found + 1))
            # Check if all tests passed
            line=$(echo "$output" | grep "^countWords:")
            fail_count=$(echo "$line" | grep -o "FAIL\|TIMEOUT\|ERROR\|SKIP" | wc -l)
            if [ "$fail_count" -eq 0 ] && echo "$line" | grep -q "PASS"; then
                countWords_pass=$((countWords_pass + 1))
            fi
        fi

        if echo "$output" | grep -q "^countCharacters: FOUND"; then
            countChars_found=$((countChars_found + 1))
            line=$(echo "$output" | grep "^countCharacters:")
            fail_count=$(echo "$line" | grep -o "FAIL\|TIMEOUT\|ERROR\|SKIP" | wc -l)
            if [ "$fail_count" -eq 0 ] && echo "$line" | grep -q "PASS"; then
                countChars_pass=$((countChars_pass + 1))
            fi
        fi

        if echo "$output" | grep -q "^findLongestWord: FOUND"; then
            longestWord_found=$((longestWord_found + 1))
            line=$(echo "$output" | grep "^findLongestWord:")
            fail_count=$(echo "$line" | grep -o "FAIL\|TIMEOUT\|ERROR\|SKIP" | wc -l)
            if [ "$fail_count" -eq 0 ] && echo "$line" | grep -q "PASS"; then
                longestWord_pass=$((longestWord_pass + 1))
            fi
        fi

        if echo "$output" | grep -q "^countWordOccurrences: FOUND"; then
            countOcc_found=$((countOcc_found + 1))
            line=$(echo "$output" | grep "^countWordOccurrences:")
            fail_count=$(echo "$line" | grep -o "FAIL\|TIMEOUT\|ERROR\|SKIP" | wc -l)
            if [ "$fail_count" -eq 0 ] && echo "$line" | grep -q "PASS"; then
                countOcc_pass=$((countOcc_pass + 1))
            fi
        fi

        if echo "$output" | grep -q "^main: FOUND"; then
            main_found=$((main_found + 1))
        fi
    else
        echo "COMPILE=FAIL"
        compile_fail=$((compile_fail + 1))
        # Show first few lines of compile errors
        head -5 "$student_dir/compile.log" 2>/dev/null | sed 's/^/  /'
    fi

    echo ""
done

# Final summary
echo "========================================="
echo "           FINAL SUMMARY"
echo "========================================="
echo "Total students:        $total_students"
echo "Compile OK:            $compile_ok"
echo "Compile FAIL:          $compile_fail"
echo "-----------------------------------------"
echo "countWords found:      $countWords_found / $compile_ok"
echo "countWords all pass:   $countWords_pass / $compile_ok"
echo "countCharacters found: $countChars_found / $compile_ok"
echo "countCharacters pass:  $countChars_pass / $compile_ok"
echo "findLongestWord found: $longestWord_found / $compile_ok"
echo "findLongestWord pass:  $longestWord_pass / $compile_ok"
echo "countWordOcc found:    $countOcc_found / $compile_ok"
echo "countWordOcc pass:     $countOcc_pass / $compile_ok"
echo "main found:            $main_found / $compile_ok"
echo "========================================="

# Cleanup
rm -rf "$WORK_DIR"
echo "Temp files cleaned up."
