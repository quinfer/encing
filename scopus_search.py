import pandas as pd
import numpy as np
from pybliometrics.scopus import ScopusSearch
query = r'(TITLE-ABS-KEY("Bayesian") AND TITLE-ABS-KEY("finance")) AND (SRCTITLE("Journal of Finance") OR  SRCTITLE("Review of Financial Studies") OR  SRCTITLE("Journal of Corporate Finance") OR  SRCTITLE("Journal of Financial and Quantitative Analysis") OR  SRCTITLE("Journal of Financial Intermediation"))'
s=ScopusSearch(query)
df=pd.DataFrame(s.results)
df.to_csv('scopus.csv')
print('Total number of results: ', s.get_results_size())
print(df[['title','publicationName','coverDisplayDate']])
