include("plotvariables.jl")
include("World3.jl")
include("odesystem.jl")


sol = solveworld3()


@named pop = Pop4.population()
@named br = CommonPop.birth_rate()
@named dr = CommonPop.death_rate()
@named is = Capital.industrial_subsector()
@named ld = Agriculture.land_development()
@named nr = NonRenewable.non_renewable()
@named pp = Pollution.persistent_pollution()


@variables t


fig_7_7_variables = [
    (nr.nrfr,  0, 1,    "nrfr"),
    (is.iopc,  0, 1000, "iopc"),
    (ld.fpc,   0, 1000, "fpc"),
    (pop.pop,  0, 16e9, "pop"),
    (pp.ppolx, 0, 32,   "ppolx"),
    (br.cbr,   0, 50,   "cbr"),
    (dr.cdr,   0, 50,   "cdr")
]

plotvariables(sol, t, fig_7_7_variables, name="Fig. 7.7", showlegend=true, showaxis=true, colored=true)
