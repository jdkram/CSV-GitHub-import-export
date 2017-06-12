# ~~~Import-issues-to-GitHub-from-CSV~~~
# Export issues from GitHub to CSV

Forked from [https://github.com/wapmesquita/CSV-GitHub-import-export], which was forked from [https://github.com/Intersection/cg-CSV-GitHub-import-export].

## Intro
Product Owners and Project Mangers _love_ spreadsheets! They want everything in spreadsheet form.

If you're using GitHub Issues (and we do) this means that one often needs to move things from GitHub into a spreadsheet ("I need a list of issues to show the client"), or from a spreadsheet into GitHub ("Here is the list of features we are committing to this sprint.") And, personally, I don't like doing things by hand if a computer can do them. And do them better.

Thus this repo.

## Installation

Make sure you have a GitHub account, that you know your username and password, and that you have access to the repository (repo) that you want to import to, or from which you wish to export.

To generate an OAuth key, which you'll need if you have 2FA enabled: [instructions on GitHub] - if you need to export issues for private GitHub repos, check all of "repo" in the permissions selection step.

Download repo and install requisite gems via bundler:
```
git clone jdkram/CSV-GitHub-import-export.git
gem install bundler
bundle install
```

## Usage

Specify your job using a config file:
```
cd CSV-GitHub-import-export
cp sample_config.yml config.yml
open config.yml
```

Sample config file:

```
organization: 'sallys-shoes'
username: 'sally'
use_password: false
password: ''
authkey: 'awdhZPBmUhV7C8KTvTXoqPrCYBfKrptqmPT6Z7Jk'
repo: 'shoe-sorter'
output_csv: './output_csvs/shoe-sorter-issues.csv'
```

## Improvements

- [x] Use config.yml file instead of commandline args (save authkeys in shell history)
- [ ] Create PDF cards from CSV (believe current workflow relies on Office mailmerge)
- [ ] Fix character encoding when opening file using Excel (instead of importing it using the Import Text dialogue & specifying encoding)

## Credits (from original repo)

- [Vik](https://github.com/datvikash) 
- [Evan](https://github.com/evan108108)
- [https://gist.github.com/henare/1106008] 
- [https://gist.github.com/tkarpinski/2369729]
