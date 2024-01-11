#.rs.restartR()
library(reticulate)
use_condaenv("pybliometrics",required = TRUE)
py_run_file("scopus_search.py")

s_results <- py$s$results

entries <- vector("list", length(s_results))

for (i in seq_along(s_results)) {
  result <- s_results[[i]]
  authors <- ifelse(!is.null(result$author_names), result$author_names, c("Unknown"))
  first_author <- strsplit(authors[1], " ")[[1]] # Split the first author's name into parts
  first_author_surname <- first_author[length(first_author)] # Assume the last part is the surname
  title <- ifelse(!is.null(result$title), result$title, "No Title")
  journal <- ifelse(!is.null(result$publicationName), result$publicationName, "No Journal")
  year <- ifelse(!is.null(result$coverDate), substr(result$coverDate, 1, 4), "No Year")
  
  # Create the bibtex_label without any delimiter between surname and year
  bibtex_label <- ifelse(first_author_surname != "Unknown" && year != "No Year", 
                         paste0(first_author_surname, year), 
                         paste0("entry", i)) # Default label if surname or year is missing
  
  volume <- ifelse(!is.null(result$volume), result$volume, "N/A")
  pages <- ifelse(!is.null(result$pageRange), result$pageRange, "N/A")
  doi <- ifelse(!is.null(result$doi), result$doi, "No DOI")
  
  entry <- sprintf("@article{%s,\n  author = {%s},\n  title = {%s},\n  journal = {%s},\n  year = {%s},\n  volume = {%s},\n  pages = {%s},\n  doi = {%s}\n}",
                   bibtex_label, paste(authors, collapse = " and "), title, journal, year, volume, pages, doi)
  entries[[i]] <- entry
}

# Combine entries into a single character vector
bib_entries <- paste(unlist(entries), collapse = "\n\n")



writeLines(bib_entries, "references.bib")
