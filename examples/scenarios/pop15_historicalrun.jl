using WorldDynamics
using ModelingToolkit

function pop15_historicalrun(; kwargs...)
    @named pop = WorldDynamics.World3.Pop15.population(; kwargs...)
    @named dr = WorldDynamics.World3.Pop15.death_rate(; kwargs...)
    @named br = WorldDynamics.World3.Pop15.birth_rate(; kwargs...)
    @named io = WorldDynamics.World3.Pop15.industrial_output(; kwargs...)
    @named so = WorldDynamics.World3.Pop15.service_output(; kwargs...)
    @named pp = WorldDynamics.World3.Pop15.persistent_pollution(; kwargs...)
    @named f  = WorldDynamics.World3.Pop15.food(; kwargs...)

    systems = [pop, dr, br, io, so, pp, f]

    connection_eqs = [
        pop.le ~ dr.le
        pop.tf ~ br.tf
        dr.fpc ~ f.fpc
        dr.sopc ~ so.sopc
        dr.iopc ~ io.iopc
        dr.ppolx ~ pp.ppolx
        br.le ~ dr.le
        br.iopc ~ io.iopc
        br.sopc ~ so.sopc
        dr.dr ~ pop.dr
        dr.pop ~ pop.pop
        br.br ~ pop.br
        br.pop ~ pop.pop
        io.pop ~ pop.pop
        so.pop ~ pop.pop
        f.pop ~ pop.pop
    ]

    return WorldDynamics.solvesystems(systems, connection_eqs, (1900.0, 2100.0))
end
