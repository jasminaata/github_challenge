require "github_api"

puts "Enter github usernames:"
usernames = STDIN.gets.chomp
mapping = {}
usernames.gsub!(/\s+/, "")

usernames.split(",").each do |name|
  github = Github.new oauth_token: "c4efe7e591058cd7ffcfb9acb515d35917ab63b7"
  repos = github.repos.list user: name

  year_ago = Time.now - 31449600
  commits_count = 0

  repos.each do |repo|
    commits = github.repos.commits.all name, repo.name, author: name, since: year_ago
    commits_count += commits.count
  end

  mapping[name] = commits_count
end

mapping = Hash[mapping.sort_by{|k, v| v}.reverse]
puts
puts "Results:"
mapping.each_pair { |key,value| puts "#{key} - #{value}"}



