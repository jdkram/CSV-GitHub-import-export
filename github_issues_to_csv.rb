#!/usr/bin/env ruby

require 'rubygems'
require 'octokit'
require 'csv'
require 'optparse' # Parsing options
require 'highline/import' # For passwords on command line
require 'yaml'

config = YAML.load_file('config.yml')

def password_prompt(message, mask='*')
  ask(message) { |q| q.echo = mask}
end

# Handle commandline args

opts_parser = OptionParser.new do |opts|
  opts.banner = "Usage: github_issues_to_csv.rb -c ./config.yml"
  opts.separator "Optionally specify path to your config file, otherwise use ./config.yml"

  opts.on("-c CONFIG", "--config CONFIG", String, "Path to your YAML config file") do |o|
    config["organization"] = o
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end
end

opts_parser.parse!(ARGV)

TIMEZONE_OFFSET="-4"
org_repo = options.organization + "/" + options.repository
TIMEZONE_OFFSET="0"

if options.authkey == ""
  options.password = password_prompt('#{options.username} password: ')
  client = Octokit::Client.new(:login => options.username, :password => options.password)
else
  client = Octokit::Client.new(:access_token => options.authkey)
end
user = client.user
user.login
 
csv = CSV.new(File.open(File.dirname(__FILE__) + "/" + options.file + ".csv", 'w', {:col_sep => ";"}))
 
puts "Initialising CSV file..."
#CSV Headers
header = [
  "Issue number",
  "Title",
  "Description",
  "Date created",
  "Date modified",
  "Labels",
  "Milestone",
  "Status",
  "Assignee",
  "Reporter"
]

csv << header
 
puts "Getting issues from Github..."
temp_issues = []
issues = []
page = 0
begin
	page = page +1
	temp_issues = client.list_issues("#{options.organization}/#{options.repository}", :state => "closed", :page => page)
	issues = issues + temp_issues;
end while not temp_issues.empty?
temp_issues = []
page = 0
begin
	page = page +1
	temp_issues = client.list_issues("#{options.organization}/#{options.repository}", :state => "open", :page => page)
	issues = issues + temp_issues;
end while not temp_issues.empty?
 
puts "Processing #{issues.size} issues..."
issues.each do |issue|

	labels = ""
	label = issue['labels'] || "None"
	if (label != "None")
		label.each do |item|
    		labels += item['name'] + " " 
    	end	
	end

	assignee = ""
	assignee = issue['assignee'] || "None"
	if (assignee != "None")
		assignee = assignee['login']
	end	

	milestone = issue['milestone'] || "None"
	if (milestone != "None")
		milestone = milestone['title']
	end
 
	if ((options.milestone == "") || (milestone == options.milestone))
    # Needs to match the header order above, date format are based on Jira default
    row = [
      issue['number'],
      issue['title'],
      issue['body'],
      DateTime.parse(issue['created_at'].to_s).new_offset(TIMEZONE_OFFSET).strftime("%d/%b/%y %l:%M %p"),
      DateTime.parse(issue['updated_at'].to_s).new_offset(TIMEZONE_OFFSET).strftime("%d/%b/%y %l:%M %p"),
      labels,
      milestone,
      issue['state'],
      assignee,
      issue['user']['login']
    ]
    csv << row
    end
end

puts "Done!"
