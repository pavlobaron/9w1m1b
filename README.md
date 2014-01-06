9w1m1b
===

Fred Brooks once used a metaphor for adding more people to a late project: "The bearing of a child takes nine months, no matter how many women are assigned." But while there are sufficient proofs that adding more people to a (late) software project doesn't (necessarily) make it get finished faster (it actually can go slower from there), what about proving his bearing metaphor, applying some simple machine learning on it?

9w1m1b is something I came up with.

Disclaimer
---

The topic and the experiment itself are not intended to be cynical or anyhow offending - please don't mistake me on that. At least, this experiment isn't more or less cynical than Brooks' statement itself. Back in that time, political correctness and sensibility haven't been taken very seriously.

This is a totally neutral, simple, public data based analysis.

Prerequisites
---

The R script needs 2 non-standatd packages: `dummies` and `DAAG`. The script itself should be executable. I only ran it on OS X, but any Unix/Linux running R should do the job. I didn't run it on Windows.

One needs the data file with the results of the corresponding NSFG survey. I've used the one still available from the [thinkstats page](http://greenteapress.com/thinkstats/nsfg.html), unzipped `2002FemPreg.dat`. Btw, the book itself is recommended to start learning statistics.

The path to the dat file needs to be hardcoded in the R script.

Running
---

Simply `./9w1m1b.R` from the project directory if file permissions are correctly set. Otherwise, `Rscript 9w1m1b.R`.

Model
---

This is the most interesting part. We need to build a regressor / predictor that predicts the pregnancy length given the number of women assigned and the healthy birth as outcome.

Comments in the script explain the steps done in R to build the and to cross-validate the model. On the general level, these steps are taken:

1. Load the data set, extracting some relevant variables
2. Introduce a new variable for the number of women assigned
3. Since every recoreded entry in the data set will have `1` woman assigned, we need to have some error in the data, so every 100th record's nr variable will be set to the maximum number in R. Data set itself contains sufficient logical errors, NAs and incorrect values, so introducing a new sort of error should work well on this scale. Otherwise the number of women assigned will be insignificant if every record will have it at `1`. Even with all these errors, the number of women assigned won't be significant enough, as the results will show. Further data manipulation can be done here, but I kept it as acceptable as possible. I did different experiments, and it kept staying relatively insignificant, even manipulating every 10th record with some random, reasonable value, for example between 1 and 5
4. `outcome` is a categorical variable, so in order to use it with the linear regression, we need to convert it into a quantitive value. A common method to do so is dummy coding, so this is also done, eliminating some errors in the records
5. Multiple regression model is then built. We want to predict the pregnancy length from number of women assigned, and from the outcome, though this always will be `1` for healthy birth. R takes care of eliminating erroneous records, for example those containing NAs. This data set is well known to contain logical errors, for example in weights. I've played around with it, but in the end I didn't use these variables, so erroneous records are kept with the hope that they won't negatively influence the result, given we have almost 14000 records
6. The 3-fold cross-validation is done for the model, showing reasonable values. Also, the summary of the linear model built shows "good" values to work with

In the end, we predict the pregnancy length for 1, 9 and 1000 women assinged, and register no difference in the result: it's around 39 weeks, which is pretty much 9 months.

My result: Brooks' metaphor can be proved right with this (slightly enriched) data set and simple multiple regression.

Isn't this complete nonsense?
---

Yes, it is.

In order to prove something that is obvious for a human, I had to implant an artificial, erroneous variable, since noone has statistically recorded the number of women assigned to a pregnancy. Nonsense, of course.

But while humans are very good in judging what makes sense on the top-most / general level and what doesn't (we build on our experiences and knowledge obtained through years of learning, building a complex net of patterns, weights etc.), machines are stupid. If one doesn't tell them what to do and what to learn from, they won't be able to adequately guess or tell nonsense from something that makes sense. Only if one teaches them that difference.

Math is fun. But it also can be used to prove or disprove complete nonsense, or to predict human behaviour, to score and categorise people based on nonsense, to tweak around facts till they fit an expected result etc. Data without brain is useless, and its analysis results anyway.

So next time I see financial scoring based on dummy variables through simple linear / multiple regression, I eventually will pull out this experiment.

License
---

Though this code is so simple that it wouldn't itself deserve a license, it's anyway published under GPL v3.

Feedback
---

Constructive feedback and improvements are very welcome, of course.