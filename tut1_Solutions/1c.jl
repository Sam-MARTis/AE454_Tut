using Plots
println("\033c")
topRange = 4
dt = [10.0^(-n) for n in 0:topRange]
x0 = 1
f = (x::Float64) -> -x;
correctAns = exp(-1)
function solveEuler(dt::Vector{Float64}, xDot, xInitial, timeInitial, timeFinal)
    solutions::Vector{Float64} = Vector{Float64}()
    for dt_i in dt
        t = timeInitial
        x = xInitial
        while t<timeFinal
            t+= dt_i
            x+= xDot(x)*dt_i
        end
        push!(solutions, x)
    end
    return solutions
    
end

sols = solveEuler(dt, f, 1.0, 0.0, 1.0)
# for i in 1:topRange+1
#     println("For time: ", round(dt[i], sigdigits=3), "   x(1): ", sols[i])
# end


absError = ((sols.-correctAns).^2).^(0.5)
lnAbsError = log.(absError)
plot(lnAbsError, log.(dt), marker="circle", label=["Error vs dt"], xlabel="ln(dt)", ylabel="ln(abs(Error))", size=(900, 800))

