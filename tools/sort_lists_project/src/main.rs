fn main() {
    let mut app = App::new("Sort Lists")
        .version("1.0")
        .author("Your Name <your.email@example.com>")
        .about("Sorts and validates DNS lists")
        .arg(
            Arg::new("proxy")
                .short('x')
                .long("proxy")
                .takes_value(true)
                .help("Sets a custom proxy URL")
        )
        .arg(
            Arg::new("help")
                .short('h')
                .long("help")
                .help("Displays help information")
        )
        .arg(
            Arg::new("donate")
                .short('d')
                .short('s')
                .long("donate")
                .long("sponsor")
                .help("Opens the default browser to the donation page")
        )
        .arg(
            Arg::new("force")
                .short('f')
                .long("force")
                .help("Forces run on all files, altered or not")
        )
        .arg(
            Arg::new("path")
                .short('p')
                .long("path")
                .takes_value(true)
                .help("Sets the path to the source directory")
        );

    let matches = app.clone().get_matches();

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
