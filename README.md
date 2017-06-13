# ~~~Import-issues-to-GitHub-from-CSV~~~
# Export issues from GitHub to CSV

Forked from https://github.com/wapmesquita/CSV-GitHub-import-export, which was forked from https://github.com/Intersection/cg-CSV-GitHub-import-export.

## Intro
Product Owners and Project Mangers _love_ spreadsheets! They want everything in spreadsheet form.

If you're using GitHub Issues (and we do) this means that one often needs to move things from GitHub into a spreadsheet ("I need a list of issues to show the client"), or from a spreadsheet into GitHub ("Here is the list of features we are committing to this sprint.") And, personally, I don't like doing things by hand if a computer can do them. And do them better.

Thus this repo.

## Installation

Make sure you have a GitHub account, that you know your username and password, and that you have access to the repository (repo) that you want to import to, or from which you wish to export.

To generate an OAuth key, which you'll need if you have 2FA enabled: [instructions on GitHub](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/) (if you need to export issues for private GitHub repos, check all of "repo" in the permissions selection step).

Download repo and install requisite gems via bundler:

```Shell
git clone https://github.com/jdkram/CSV-GitHub-import-export.git
gem install bundler
bundle install
```

## Usage

Specify your job using a config file:
```Shell
cd CSV-GitHub-import-export
cp sample_config.yml config.yml
open config.yml
```

The script will default to using `./config.yml` but you can specify a configuration file:

```Shell
./github_issues_to_csv.rb -c ./other_config_file.yml
```

Sample config file:

```YAML
organization: 'sallys-shoes'
username: 'sally'
repo: 'shoe-sorter'
use_password: false
milestone: 'Redesign' # Optional
password: '' # Optional
authkey: 'awdhZPBmUhV7C8KTvTXoqPrCYBfKrptqmPT6Z7Jk' # Optional
output_csv: './output_csvs/shoe-sorter-issues.csv' # Optional
```

To run with the default config file:

```shell
./github_issues_to_csv.rb
```

If no output_csv path is specified, `./output_csvs/organization_repo-name.csv` will be created.

## Improvements

- [x] Use config.yml file instead of commandline args (save authkeys in shell history)
- [ ] Create PDF cards from CSV (believe current workflow relies on Office mailmerge)
- [ ] Fix character encoding when opening file using Excel (instead of importing it using the Import Text dialogue & specifying encoding)

## Credits (from original repo)

- [Vik](https://github.com/datvikash) 
- [Evan](https://github.com/evan108108)
- https://gist.github.com/henare/1106008
- https://gist.github.com/tkarpinski/2369729
