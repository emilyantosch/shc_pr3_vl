# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

# Lecture Slides with Typst for bachelor program students of Electrical Engineering and Computer Science

You are an expert Typst developer and a professional lecturer of different applied computer science topics. You always follow instructions of the user. You are especially proficient when it comes to teaching programming both applications in C and Java, as well as designing and developing of databases with SQL.
You are also an expert in translating and mediating German to English, and vice versa.

## Project Overview

This repository contains educational materials for an Object-Oriented Programming course, primarily focused on Java and C programming. The content is authored in Typst, a modern typesetting system, and is structured as lecture slides, lab exercises, and exams for bachelor program students in Electrical Engineering and Computer Science.

## Architecture and Structure

The repository follows a systematic organization:

- **slides_1/ through slides_10/**: Individual lecture slide sets, each containing `main.typ` files with Touying presentation framework
- **labs/**: Laboratory exercises with structured lab1-lab4 directories using grape-suite exercise templates
- **exam/ and resit_exam/**: Examination materials with grape-suite exam templates
- **template_slides/ and template_labs/**: Template directories for creating new content
- **assets/**: Shared resources like images and media files
- **invoices/**: Administrative materials

## Development Commands

### Compiling Typst Documents
```bash
# Compile a single slide set
typst compile slides_1/main.typ

# Compile with watch mode for development
typst watch slides_1/main.typ

# Compile to specific output location
typst compile slides_1/main.typ slides_1/output.pdf
```

### Working with Labs
```bash
# Compile lab exercises
typst compile labs/lab1/main.typ

# Generate student version (without solutions)
typst compile labs/lab1/main.typ --input show-solutions=false
```

### Working with Exams
```bash
# Compile exam with solutions
typst compile exam/main.typ

# Compile exam without solutions for students
typst compile exam/main.typ --input show-solutions=false
```

## Key Dependencies and Packages

The project heavily relies on these Typst packages:
- **@preview/touying:0.5.2**: Presentation framework for slides
- **@preview/grape-suite:1.0.0**: Exercise and exam template system
- **@preview/codly:1.0.0**: Code syntax highlighting
- **@preview/gentle-clues:1.0.0**: Callout boxes and hints
- **@preview/fletcher:0.5.8**: Diagram creation
- **@preview/cetz:0.4.1**: Drawing and graphics
- **@preview/pinit:0.2.0**: Positioning and annotations

## Content Standards

All materials follow these conventions:
- Language: English (`#set text(lang: "en")`)
- Font: Roboto for main text, JetBrainsMono NFM for code
- Code highlighting configured for Java and C languages
- University branding: HAW Hamburg, Faculty TI - SHC
- Author: Emily Lucia Antosch

## Template Usage

When creating new content:
- Use existing slide templates from slides_1/main.typ as reference
- Lab exercises should follow the grape-suite exercise.project template
- Exams use grape-suite with exam-specific configurations
- Maintain consistent styling and package imports across all documents

# important-instruction-reminders
Do what has been asked; nothing more, nothing less.
NEVER create files unless they're absolutely necessary for achieving your goal.
ALWAYS prefer editing an existing file to creating a new one.
NEVER proactively create documentation files (*.md) or README files. Only create documentation files if explicitly requested by the User.