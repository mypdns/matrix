use std::collections::HashSet;
use std::fs::File;
use std::io::{BufRead, BufReader};
use std::process::Command;
use std::time::Instant;

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

fn fetch_valid_tlds() -> HashSet<String> {
    let url = "https://data.iana.org/TLD/tlds-alpha-by-domain.txt";
    let response = reqwest::blocking::get(url).expect("Failed to fetch TLDs");
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
    let start = Instant::now();
    let valid_tlds = fetch_valid_tlds();
    let alphanum_filenames = ["wildcard.csv", "mobile.csv", "snuff.csv"];
    let modified_files = get_modified_files_in_last_commit();
    let target_files_alphanum = find_files_by_name("source", &alphanum_filenames);

    for file in target_files_alphanum {
        if modified_files.iter().any(|mf| file.ends_with(mf)) {
            sort_file_alphanum(&file, &valid_tlds);
        }
    }

    let duration = start.elapsed();
    println!("Time elapsed: {:?}", duration);
}
