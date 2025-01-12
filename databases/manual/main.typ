#import "@preview/grape-suite:1.0.0": exercise, german-dates
#import "@preview/gentle-clues:1.0.0": *
#import "@preview/pinit:0.2.0": *
#import "@preview/codly:1.0.0": *
#show: codly-init.with()

#import "@preview/numbly:0.1.0": numbly

#set text(lang: "en")
#set heading(numbering: numbly("{1}.", default: "1.1"))

#set align(left + top)


#codly(
  languages: (
    sql: (
      name: text(font: "JetBrainsMono NFM", " SQL", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e76e}", weight: "bold"), color: rgb("#2563eb"),
    ),
    java: (
      name: text(font: "JetBrainsMono NFM", " Java", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e738}", weight: "bold"), color: rgb("#CE412B"),
    ), c: (
      name: text(font: "JetBrainsMono NFM", " C", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e61e}", weight: "bold"), color: rgb("#5612EC"),
    ),
    sh: (
      name: text(font: "JetBrainsMono NFM", " Shell", weight: "bold"), icon: text(font: "JetBrainsMono NFM", "\u{e691}", weight: "bold"), color: rgb("#56E615"),
    ),
  ),
)

#show: exercise.project.with(
  title: "Installation Instructions for PostgreSQL", university: [HAW Hamburg], institute: [TI IE4], seminar: [DBL], abstract: [
This document provides a comprehensive guide to installing PostgreSQL 16 on Windows, macOS, and Linux operating systems. It includes step-by-step instructions, prerequisites, and verification steps for each operating system, as well as additional tips and resources. 
  ], show-outline: true, author: "Emily Antosch", show-solutions: false,
)
= Installing PostgreSQL 16 on Windows, macOS, and Linux

Installing PostgreSQL 16 on Windows, macOS, and Linux involves different processes for each operating system. Here's a comprehensive guide for each platform:
PostgreSQL is a powerful, open-source object-relational database system renowned for its reliability, data integrity, and extensibility. PostgreSQL 16 introduces several enhancements, including a new memory management system for VACUUM to reduce memory consumption and improve performance, new SQL/JSON capabilities, and various query performance improvements @postgresql_website. This comprehensive guide provides step-by-step instructions for installing PostgreSQL 16 on Windows, macOS, and Linux operating systems, drawing from official documentation and top tutorials.

== Installing PostgreSQL 16 on Windows

=== Prerequisites @postgresql_requirements

- A Windows operating system with administrator privileges.
- 1 GHz processor.
- 2 GB of RAM.
- 512 MB of HDD space, with additional space for data and components. Apply any pending Windows updates.

=== Step-by-Step Instructions
1. Download the Installer: Go to the #link("https://www.postgresql.org/download/")[PostgreSQL downloads page] and select the Windows installer for the latest version.
2. Run the Installer: Double-click the downloaded installer.
3. Click "Next" on the welcome screen.
4. Choose the installation directory or accept the default. Click "Next."
5. Select the components to install (PostgreSQL Server and pgAdmin 4 are recommended). Click "Next."
6. Choose the data directory or accept the default. Click "Next."
7. Set a strong password for the database superuser (postgres). This password will be required every time you connect to the database, so make sure it is secure and memorable. Click "Next."
8. Set the port number (the default is 5432). Click "Next."
9. Choose the default locale or accept the default. Click "Next."
10. Review the pre-installation summary and click "Next."
11. Wait for the installation to complete.
12. Click "Finish."

*Adding PostgreSQL to PATH*
  - To conveniently access PostgreSQL commands from the command line, add the path to the PostgreSQL bin directory to your system's PATH environment variable. This allows you to run commands like psql without specifying the full path to the executable.

*Verification*
- Open pgAdmin 4. pgAdmin 4 is a popular open-source administration and management tool for PostgreSQL that provides a user-friendly graphical interface for interacting with your databases 6.
- Connect to the default database (postgres) using the password you set during installation.


== Installing PostgreSQL 16 on macOS

=== Prerequisites
- Homebrew package manager
- Sufficient disk space for PostgreSQL and its data
- An ISO/ANSI C compiler (at least C99-compliant)
- tar, gzip, or bzip2 for unpacking the source distribution (if building from source)
- flex and bison (if building from source)

=== Step-by-Step Instructions

*Using Homebrew*
1. Install Homebrew: If you don't have Homebrew, a popular package manager for macOS, install it from their official website 8.
2. Install PostgreSQL: Open a terminal and run:
```sh
brew install postgresql@16
```
3. Add PostgreSQL to System Path:
```sh
echo 'export PATH="/usr/local/opt/postgresql@16/bin:$PATH"' >> ~/.zshrc
```
4. Start PostgreSQL Service:
```sh
brew services start postgresql@16
```

*Manual Installation*
- You can also install PostgreSQL 16 on macOS using a package installer (.dmg file). Download the .dmg file from the PostgreSQL website and follow the graphical installer instructions.

== Linux Installation (Ubuntu)

1. **Add PostgreSQL repository:**
   - Run these commands to add the official PostgreSQL repository[3]:
     ```bash
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
     sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
     ```

2. **Update package lists:**
   - Run:
     ```bash
     sudo apt update
     ```

3. **Install PostgreSQL 16:**
   - Install PostgreSQL with:
     ```bash
     sudo apt install postgresql-16
     ```

4. **Create a custom data directory (optional):**
   - If you want to use a custom directory for storing database files:
     ```bash
     sudo mkdir -p /postgres/pgdata
     sudo chown postgres:postgres /postgres/pgdata
     sudo chmod 700 /postgres/pgdata
     ```

5. **Initialize the new data directory:**
   - If using a custom directory:
     ```bash
     sudo su - postgres
     /usr/lib/postgresql/16/bin/initdb -D /postgres/pgdata
     exit
     ```

6. **Configure PostgreSQL:**
   - Edit `/etc/postgresql/16/main/postgresql.conf` to set the `data_directory` if you're using a custom location[3].

7. **Set a password for the postgres user:**
   - Run:
     ```bash
     sudo -u postgres psql
     ALTER USER postgres PASSWORD 'your_password';
     \q
     ```

8. **Enable remote connections (optional):**
   - Edit `/etc/postgresql/16/main/postgresql.conf` to set `listen_addresses = '*'`[3].
   - Modify `/etc/postgresql/16/main/pg_hba.conf` to allow connections from desired IP ranges[3].

9. **Start PostgreSQL service:**
   - Run:
     ```bash
     sudo systemctl start postgresql
     ```

10. **Verify installation:**
    - Check PostgreSQL status:
      ```bash
      sudo systemctl status postgresql
      ```

Remember to adjust security settings and passwords according to your needs and always follow best practices for database security[1][2][3].

#bibliography("lib.bib")
