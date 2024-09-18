set.seed(123)

def <- defData(varname = "group", formula = 0, dist = "binary")
def <- defData(def, varname = "x", formula = "0 + 0.5*group", dist = "normal", variance = 1)
def <- defData(def, varname = "y", formula = "2 + 1.5*group + 0.8*x", dist = "normal", variance = 1)

sim_data <- genData(200, def)