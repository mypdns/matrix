#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <unordered_set>
#include <algorithm>
#include <regex>
#include <filesystem>
#include <chrono>
#include <curl/curl.h>

namespace fs = std::filesystem;

std::vector<std::string> find_files_by_name(const std::string& directory, const std::vector<std::string>& filenames) {
    std::vector<std::string> matches;
    for (const auto& entry : fs::recursive_directory_iterator(directory)) {
        if (fs::is_regular_file(entry)) {
            std::string file_name = entry.path().filename().string();
            if (std::find(filenames.begin(), filenames.end(), file_name) != filenames.end()) {
                matches.push_back(entry.path().string());
            }
        }
    }
    return matches;
}

std::vector<std::string> get_modified_files_in_last_commit() {
    std::vector<std::string> modified_files;
    std::string command = "git diff --name-only HEAD~1 HEAD";
    std::array<char, 128> buffer;
    std::string result;
    std::shared_ptr<FILE> pipe(popen(command.c_str(), "r"), pclose);
    if (!pipe) throw std::runtime_error("popen() failed!");
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    std::istringstream iss(result);
    for (std::string line; std::getline(iss, line); ) {
        modified_files.push_back(line);
    }
    return modified_files;
}

std::unordered_set<std::string> fetch_valid_tlds() {
    std::unordered_set<std::string> valid_tlds;
    CURL* curl;
    CURLcode res;
    curl = curl_easy_init();
    if (curl) {
        curl_easy_setopt(curl, CURLOPT_URL, "https://data.iana.org/TLD/tlds-alpha-by-domain.txt");
        curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, +[](void* contents, size_t size, size_t nmemb, void* userp) -> size_t {
            ((std::string*)userp)->append((char*)contents, size * nmemb);
            return size * nmemb;
        });
        std::string response_string;
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response_string);
        res = curl_easy_perform(curl);
        if (res == CURLE_OK) {
            std::istringstream iss(response_string);
            for (std::string line; std::getline(iss, line); ) {
                if (line[0] != '#') valid_tlds.insert(line);
            }
        }
        curl_easy_cleanup(curl);
    }
    return valid_tlds;
}

bool is_valid_domain(const std::string& domain, const std::unordered_set<std::string>& valid_tlds) {
    std::regex re(R"((?:[a-zA-Z0-9_](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9_])?\.)+[a-zA-Z]{2,63}$)");
    if (!std::regex_match(domain, re)) return false;
    auto pos = domain.find_last_of('.');
    if (pos != std::string::npos) {
        std::string tld = domain.substr(pos + 1);
        return valid_tlds.find(tld) != valid_tlds.end();
    }
    return false;
}

std::vector<std::string> remove_duplicates(const std::vector<std::string>& lines) {
    std::unordered_set<std::string> seen;
    std::vector<std::string> unique_lines;
    for (const auto& line : lines) {
        if (seen.insert(line).second) {
            unique_lines.push_back(line);
        }
    }
    return unique_lines;
}

void sort_file_alphanum(const std::string& file_path, const std::unordered_set<std::string>& valid_tlds) {
    std::ifstream infile(file_path);
    std::vector<std::string> lines;
    for (std::string line; std::getline(infile, line); ) {
        lines.push_back(line);
    }

    lines = remove_duplicates(lines);
    std::sort(lines.begin(), lines.end(), [](const std::string& a, const std::string& b) {
        return a.substr(0, a.find(',')).compare(b.substr(0, b.find(','))) < 0;
    });

    // Add your domain validation and connectivity test logic here

    // Print invalid entries (example)
    for (const auto& line : lines) {
        if (!is_valid_domain(line, valid_tlds)) {
            std::cout << "Invalid DNS entry: " << line << std::endl;
        }
    }
}

int main() {
    auto start = std::chrono::high_resolution_clock::now();

    auto valid_tlds = fetch_valid_tlds();
    std::vector<std::string> alphanum_filenames = {"wildcard.csv", "mobile.csv", "snuff.csv"};
    auto modified_files = get_modified_files_in_last_commit();
    auto target_files_alphanum = find_files_by_name("source", alphanum_filenames);

    for (const auto& file : target_files_alphanum) {
        if (std::any_of(modified_files.begin(), modified_files.end(), [&file](const std::string& mf) { return file.ends_with(mf); })) {
            sort_file_alphanum(file, valid_tlds);
        }
    }

    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<double> duration = end - start;
    std::cout << "Time elapsed: " << duration.count() << " seconds" << std::endl;

    return 0;
}
