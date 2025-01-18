use std::collections::HashSet;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::process::{Command, exit};
use std::time::Instant;
use clap::{App, Arg}; // Add this line
use reqwest::blocking::Client;
use reqwest::Proxy;
use webbrowser;

fn find_files_by_name(directory: &str, filenames: &[&str]) -> Vec<String> {
    let mut matches = Vec::new();
    for entry in walkdir::WalkDir::new(directory) {
        let entry = entry.unwrap();
        if entry.file_type().is_file() {
            let file_name = entry.file_name().to_string_lossy();
            if filenames.contains(&file_name.as_ref()) {
                matches.push(entry.path().display().to_string());
            }
        }
    }
    matches
}

fn get_modified_files_in_last_commit() -> Vec<String> {
    let output = Command::new("git")
        .args(&["diff", "--name-only", "HEAD~1", "HEAD"])
        .output()
        .expect("Failed to execute git command");
    let output_str = String::from_utf8_lossy(&output.stdout);
    output_str.lines().map(|s| s.to_string()).collect()
}

fn fetch_valid_tlds(proxy: Option<&str>) -> HashSet<String> {
    let client = match proxy {
        Some(p) => Client::builder()
            .proxy(Proxy::all(p).expect("Invalid proxy URL"))
            .build()
            .expect("Failed to build client with proxy"),
        None => Client::new(),
    };

    let url = "https://data.iana.org/TLD/tlds-alpha-by-domain.txt";
    let response = client.get(url).send().expect("Failed to fetch TLDs");
    let content = response.text().expect("Failed to read response text");

    content
        .lines()
        .filter(|line| !line.starts_with('#'))
        .map(|line| line.to_lowercase())
        .collect()
}

fn is_valid_domain(domain: &str, valid_tlds: &HashSet<String>) -> bool {
    if let Some(tld) = domain.split('.').last() {
        if !valid_tlds.contains(tld) {
            return false;
        }
    }
    let re = regex::Regex::new(r"^(?:[a-zA-Z0-9_](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9_])?\.)+[a-zA-Z]{2,63}$").unwrap();
    re.is_match(domain)
}

fn remove_duplicates(lines: Vec<String>) -> Vec<String> {
    let mut seen = HashSet::new();
    let mut unique_lines = Vec::new();
    for line in lines {
        if seen.insert(line.clone()) {
            unique_lines.push(line);
        }
    }
    unique_lines
}

fn sort_file_alphanum(file_path: &str, valid_tlds: &HashSet<String>) {
    let file = File::open(file_path).expect("Failed to open file");
    let reader = BufReader::new(file);
    let mut lines: Vec<String> = reader.lines().filter_map(Result::ok).collect();

    lines = remove_duplicates(lines);

    lines.sort_by(|a, b| a.split(',').next().unwrap().cmp(b.split(',').next().unwrap()));

    // Add your domain validation and connectivity test logic here

    // Print invalid entries (example)
    for line in &lines {
        if !is_valid_domain(line, valid_tlds) {
            println!("Invalid DNS entry: {}", line);
        }
    }
}

fn main() {
    let app = App::new("Sort Lists")
        .version("1.0")
        .author("Your Name <your.email@example.com>")
        .about("Sorts and validates DNS lists")
        .arg(
            Arg::new("proxy")
                .short('x')
                .long("proxy")
                .takes_value(true)
                .about("Sets a custom proxy URL")
        )
        .arg(
            Arg::new("help")
                .short('h')
                .long("help")
                .about("Displays help information")
        )
        .arg(
            Arg::new("donate")
                .short('d')
                .short('s')
                .long("donate")
                .long("sponsor")
                .about("Opens the default browser to the donation page")
        )
        .arg(
            Arg::new("force")
                .short('f')
                .long("force")
                .about("Forces run on all files, altered or not")
        )
        .arg(
            Arg::new("path")
                .short('p')
                .long("path")
                .takes_value(true)
                .about("Sets the path to the source directory")
        );

    let matches = app.get_matches();

    if matches.is_present("help") {
        println!("{}", app.render_usage());
        exit(0);
    }

    if matches.is_present("donate") {
        if webbrowser::open("https://www.mypdns.org/donate").is_ok() {
            println!("Opened donation page in default browser.");
        } else {
            eprintln!("Failed to open donation page.");
        }
        exit(0);
    }

    let proxy = if std::env::var("CI").is_ok() {
        None
    } else {
        matches.value_of("proxy").or(Some("socks5h://localhost:9050"))
    };

    let source_path = matches.value_of("path").unwrap_or("source");

    let start = Instant::now();
    let valid_tlds = fetch_valid_tlds(proxy);
    let alphanum_filenames = ["wildcard.csv", "mobile.csv", "snuff.csv"];
    let modified_files = if matches.is_present("force") {
        find_files_by_name(source_path, &alphanum_filenames)
    } else {
        get_modified_files_in_last_commit()
    };
    let target_files_alphanum = find_files_by_name(source_path, &alphanum_filenames);

    for file in target_files_alphanum {
        if matches.is_present("force") || modified_files.iter().any(|mf| file.ends_with(mf)) {
            sort_file_alphanum(&file, &valid_tlds);
        }
    }

    let duration = start.elapsed();
    println!("Time elapsed: {:?}", duration);
}
