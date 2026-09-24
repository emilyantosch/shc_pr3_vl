# Compile every course's slides; keep historical exports under their old names.
compile_slides rev:
    @for dir in SOL2/slides_* databases/slides_* SHC_PR3/slides_*; do \
        deck=$(basename "$dir"); \
        typst compile --root . "$dir/main.typ" "$dir/{{ datetime("%Y%m%d") }}_${deck}_hestia_rev{{rev}}.pdf" || exit; \
    done

# Build all 30 decks in a temporary directory and check their PDF layouts.
check_slides:
    uv run --no-project --with pymupdf python SOL2/hestia/check_courses.py
