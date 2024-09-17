## This is a header

Here's a list:

    - First item
    - Second item

This is a reference: @abadieWhenShouldYou2023.

```
var code = "This is an example code?"
```

## LaTeX

LaTeX will also work both inline ($x \neq y$) and with align environments:

\begin{align*}
\parbox[t]{\textwidth}{\centering $Attitude_i = \alpha + \beta_1 condition_i + \beta_2 LowSkill_i + \beta_3 highIncome_i
\beta_4 condition_i \times LowSkill_i \newline
    + \beta_5 condition_i \times highIncome_i + \beta_6 LowSkill_i \times highIncome_i \newline
    + \beta_7 condition_i \times LowSkill_i \times highIncome_i + \beta_8 X_i \newline
    + \beta_9 condition_i \times X_i + \beta_{10} LowSkill_i \times X_i + \epsilon_i.$} \stepcounter{equation}\tag{\theequation}\label{eqn:model2}
\end{align*}

## Figures

Insert a figure with `\insertfigure{label}{filename}{caption}`.

\insertfigure{descriptive}{sample_figure.pdf}{Bar plot of survey responses to outcomes of interest grouped by condition and skill. The chart on the top right shows the heatmap of responses with a polychoric correlation score.}

## Tables

\input{sample_table.tex}