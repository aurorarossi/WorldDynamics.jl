module NonRenewable


using ModelingToolkit

include("../functions.jl")
include("nonrenewable/tables.jl")
include("nonrenewable/parameters.jl")
include("nonrenewable/initialisations.jl")


@register interpolate(x, y::NTuple, xs::Tuple)
@register clip(f1, f2, va, th)

@variables t
D = Differential(t)


function population(; name, params=params, inits=inits)
    @parameters gc = params[:gc]
    @parameters pop2 = params[:pop2]
    @parameters popi = params[:popi]
    @parameters zpgt = params[:zpgt]

    @variables pop(t), pop1(t)

    eqs = [
        pop ~ clip(pop2, pop1, t, zpgt)
        pop1 ~ popi * exp(gc * (t - 1900))
    ]

    ODESystem(eqs; name)
end

function industrial_output(; name, params=params, inits=inits)
    @parameters icor = params[:icor]

    @variables ic(t) fcaor(t) pop(t)
    @variables io(t) iopc(t)

    eqs = [
        io ~ ic * (1 - fcaor) / icor
        iopc ~ io / pop
    ]

    ODESystem(eqs; name)
end

function industrial_capital(; name, params=params, inits=inits)
    @parameters fioaa = params[:fioaa]
    @parameters fioas = params[:fioas]
    @parameters fioac = params[:fioac]
    @parameters alic = params[:alic]

    @variables io(t)
    @variables ic(t) = inits[:ic0]
    @variables icir(t) icdr(t)

    eqs = [
        D(ic) ~ icir - icdr
        icir ~ io * (1 - fioaa - fioas - fioac)
        icdr ~ ic / alic
    ]

    ODESystem(eqs; name)
end

function non_renewable(; name, params=params, inits=inits)
    @parameters nri = params[:nri]
    @parameters nruf1 = params[:nruf1]
    @parameters nruf2 = params[:nruf2]
    @parameters pyear = params[:pyear]

    @variables pop(t) iopc(t)
    @variables nr(t) = params[:nri]
    @variables nrur(t) nruf(t) pcrum(t) nrfr(t) fcaor(t) fcaor1(t) fcaor2(t)

    eqs = [
        D(nr) ~ -nrur
        nrur ~ pop * pcrum * nruf
        nruf ~ clip(nruf2, nruf1, t, pyear)
        pcrum ~ interpolate(iopc, pcrumt, pcrumts)
        nrfr ~ nr / nri
        fcaor ~ clip(fcaor2, fcaor1, t, pyear)
        fcaor1 ~ interpolate(nrfr, fcaor1t, fcaor1ts)
        fcaor2 ~ interpolate(nrfr, fcaor2t, fcaor2ts)
    ]

    ODESystem(eqs; name)
end


end # module