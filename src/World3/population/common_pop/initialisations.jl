t0 = 1900
pop0 = 1.61e9 # lines 1-3 page 167
sopc0 = 1.5e11 / pop0 # lines 76-82 page 168
hsapc0 = interpolate(sopc0, hsapct, hsapcts) # lines 11-12 page 167
ehspc0 = hsapc0 # lines 13-14 page 167
fpc0 = 4e11 / pop0 # lines 83-89 page 168
lmf0 = interpolate(fpc0 / params["sfpcv"], lmft, lmfts) # lines 8-10 page 167
lmhs0 = interpolate(ehspc0, lmhs1t, lmhs1ts) # lines 15-20 page 167
ppolx0 = 1.0 # lines 73-75 page 168
lmp0 = interpolate(ppolx0, lmpt, lmpts) # lines 26-27 page 167
iopc0 = 0.7e11 / pop0 # lines 64-72 page 168
cmi0 = interpolate(iopc0, cmit, cmits) # lines 23-24 page 167
fpu0 = interpolate(pop0, fput, fputs) # lines 21-22 page 167
lmc0 = 1 - cmi0 * fpu0 # line 25 page 167
le0 = params["lenv"] * lmf0 * lmhs0 * lmp0 * lmc0 # lines 6-7 page 167
fm0 = interpolate(le0, fmt, fmts) # lines 36-37 page 168
mtf0 = params["mtfnv"] * fm0 # lines 34-35 page 168
frsn0 = 0.82 # lines 50-52 page 168
sfsn0 = interpolate(iopc0, sfsnt, sfsnts)  # lines 46-49 page 168
dcfs0 = params["dcfsnv"] * frsn0 * sfsn0 # lines 43-45 page 168
ple0 = le0 # lines 41-42 page 168
cmple0 = interpolate(ple0, cmplet, cmplets) # lines 39-40 page 168
dtf0 = dcfs0 * cmple0 # line 38 page 168
nfc0 = mtf0 / dtf0 - 1.0 # line 56 page 168
fsafc0 = interpolate(nfc0, fsafct, fsafcts) # lines 62-63 page 168
fcapc0 = fsafc0 * sopc0 # line 61 page 168
# TODO: see which ones of the following are necessary
fcfpc0 = fcapc0 # line 60 page 168
fce0 = interpolate(fcfpc0, fcet, fcets) # lines 57-59 page 168
tf0 = min(mtf0, mtf0 * (1 - fce0) + dtf0 * fce0) # line 33 page 168
br0 = tf0 * pop0 * params["ffwv"] / params["rltv"] # lines 28-31 page 168
cbr0 = 1000 * br0 / pop0 # line 32 page 168
