---
title: "Sample slides"
author: "Matias Faure"
header-includes:
  - \usepackage{tikz}
  - \usetikzlibrary{shapes, positioning, arrows.meta, arrows}
---

## Slide header

This is a first page.

\bigskip
\pause

This is a second page.

:::notes
These are notes
:::

## Image example

![](./project_template/assets/figures/sample_figure.pdf)

## Tikz example

\resizebox{\textwidth}{!}{%
  \begin{tikzpicture}
    [
      node distance=1cm and 1.5cm,
      every node/.style={draw, rectangle, minimum size=1.5cm, align=center, font=\scriptsize},
      arrow/.style={-Stealth, thick}
    ]

    % Level 1 to Level 3 (horizontal placement)
    \node (L1) [yshift=-1cm] {Recruitment};
    \node (L2) [right=of L1] {Screening};
    \node (L3b) [right=of L2] {Immigration \\ prime};
    \node (L3) [right=of L3b] {Religion \\ ask};
    \node (L10) [above=of L3b] {Measure \\ priors};

    % Arrows from Level 1 to Level 3
    \draw [arrow] (L1) -- (L2) node[midway, above, fill=none, draw=none] {$\frac{1}{s}n$};
    \draw [arrow] (L2) -- (L3b) node[midway, above, fill=none, draw=none] {$ n $};
    \draw [arrow] (L3b) -- (L3) node[midway, below, fill=none, draw=none] {$0.9n$};
    \draw [arrow] (L3b) -- (L10) node[midway, right, fill=none, draw=none] {$0.1n$};
    \draw [arrow] (L10) -- (L3);

    % Level 4 - Four parallel nodes (vertical placement)
    \node (L4b) [right=of L3] {Christian decline};
    \node (L4a) [above=of L4b] {Christian decline \& \\ Religious immigrants};
    \node (L4c) [below=of L4b] {Religious immigrants};
    \node (L4d) [below=of L4c] {Control};

    % Arrows to Level 4 nodes
    \draw [arrow] (L3) -- (L4a) node[midway, above, fill=none, draw=none] {$\frac{n}{4}$};
    \draw [arrow] (L3) -- (L4b) node[midway, above, fill=none, draw=none] {$\frac{n}{4}$};
    \draw [arrow] (L3) -- (L4c) node[midway, above, fill=none, draw=none] {$\frac{n}{4}$};
    \draw [arrow] (L3) |- (L4d) node[midway, below, fill=none, draw=none] {$\frac{n}{4}$};

    % Level 5
    \node (L5) [right=of L4b] {Measure immigration \\ attitudes};

    % Arrows from Level 4 nodes to Level 5
    \draw [arrow] (L4a.east) -- (L5);
    \draw [arrow] (L4b.east) -- (L5);
    \draw [arrow] (L4c.east) -- (L5);
    \draw [arrow] (L4d.east) -- (L5);

    % Level 6 to Level 9 (horizontal placement)
    \node (L6) [above=of L5, draw=red, text=red] {Manipulation \\ checks};
    \node (L7) [right=of L5] {Secondary \\ outcomes};
    \node (L8) [right=of L7] {Demographic \\ questions};
    \node (L9) [below=of L8] {Religion \\ re-ask};

    % Arrows from Level 5 to Level 9
    \draw [arrow] (L5) -- (L6) node[midway, right, fill=none, draw=none, text=red] {$0.1 n$};
    \draw [arrow] (L6) -- (L7);
    \draw [arrow] (L5) -- (L7) node[midway, below, fill=none, draw=none] {$0.9 n$};
    \draw [arrow] (L7) -- (L8);
    \draw [arrow] (L8) -- (L9) node[midway, right, fill=none, draw=none] {$0.1 n$};

  \end{tikzpicture}
}