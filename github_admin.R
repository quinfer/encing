library(rio)
library(googledrive)
library(usethis)
library(ghclass)
library(purrr)
library(tidyverse)
credentials::set_github_pat()
'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'
org="advanced-financial-data-analytics"
org_members("advanced-financial-data-analytics")->current_members
current_student_members<-setdiff(current_members,"quinfer")
org_remove(org = org,current_student_members,prompt = FALSE )
org_repos(org=org)-> all_repos
to_keep=paste0("advanced-financial-data-analytics/",c("hw1","hw2","hw3","hw4","mock-exam","github-start-course"))
repos_to_delete<-setdiff(all_repos,to_keep)

for (i in repos_to_delete) {
  repo_delete(i,prompt = FALSE)
}


org_pending("Time-series-financial-econometrics"))->invites_so_far
org_invite(org = "Time-series-financial-econometrics",user = students_info|>
             filter(!(`Github Username` %in% invites_so_far)) %>% {.$`Github Username`})

# Wrong usernames.
wrongs<-c("chiraag777","dufeng lin","vkompoella01")
students_info %>% filter(`Github Username` %in% wrongs)
# Remove last years student individual reports
org_repos(org = "Time-series-financial-econometrics",filter = "-ind")->old_student_repos
old_student_repos %>% map(~repo_delete(repo = .x,prompt = FALSE))
students_info |> filter(grepl("dufeng lin|chiraag777",`Github Username`))
## Set repo as template
repo_is_template('Time-series-financial-econometrics/hw3')
repo_set_template('Time-series-financial-econometrics/hw3')
repo_is_template('Time-series-financial-econometrics/rethinking-prediction-report')
repo_set_template('Time-series-financial-econometrics/rethinking-prediction-report')


## First homework assignment created
org_members("Time-series-financial-econometrics")
exceptions<-c("Time-series-financial-econometrics/hw1-ind-NANDANROHILLA", "Time-series-financial-econometrics/hw1-ind-GhassanShabab", "Time-series-financial-econometrics/hw1-ind-HANGLINGCHUNG", "Time-series-financial-econometrics/hw1-ind-YuanyangC", "Time-series-financial-econometrics/hw1-ind-rcampbell66", "Time-series-financial-econometrics/hw1-ind-MayurGopal", "Time-series-financial-econometrics/hw1-ind-aqilfriyan", "Time-series-financial-econometrics/hw1-ind-RupaliWakchaure", "Time-series-financial-econometrics/hw1-ind-Vijay-Malliah", "Time-series-financial-econometrics/hw1-ind-AliyahMukadam", "Time-series-financial-econometrics/hw1-ind-moe5445", "Time-series-financial-econometrics/hw1-ind-keshan00", "Time-series-financial-econometrics/hw1-ind-cwolfe05", "Time-series-financial-econometrics/hw1-ind-jayanthkarunika")
str_remove_all(exceptions,"Time-series-financial-econometrics/hw1-ind-")
new_members<-setdiff(str_remove_all(exceptions,"Time-series-financial-econometrics/hw1-ind-"),org_members("Time-series-financial-econometrics"))

org_create_assignment(
  org = "Time-series-financial-econometrics",
  user = new_members,
  repo = paste0("hw1-ind-",new_members),
  source_repo = "Time-series-financial-econometrics/hw1",
  private = TRUE
)


## Reboot individuals student issues
repo_delete('Time-series-financial-econometrics/hw2-ind-ChenfangCao')

org_create_assignment(
  org = "Time-series-financial-econometrics",
  user = 'ChenfangCao',
  repo = paste0("hw2-ind-",'ChenfangCao'),
  source_repo = "Time-series-financial-econometrics/hw2",
  private = TRUE
)



## Create project teams repo's----
Distributing a team assignment
Once you have created your template repository,
it is then straight forward process to create the
team or individual repositories for your students.
The recommended process is to use the org_create_assignment function,
which is a high level function that takes care of each of the
underlying steps for you. To start we will create
the hw1 team-based assignment given the teams in roster.


org_create_assignment(
  org = "Time-series-financial-econometrics",
  user = roster$github,
  repo = roster$team,
  team = roster$team,
  source_repo = "Time-series-financial-econometrics/rethinking-prediction-report",
  private = TRUE
)

repo_ls(repo = "Time-series-financial-ecnometrics/rethinking-prediction-report")

# subset of adjustments
