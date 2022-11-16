using Plots

# Constants
g = 32
l = 3
w = sqrt(g/l)
R = 2
G = 1
θ₀ = π/6
v = 0
C = (R*G^2)/(l*(w^2-G^2))

function update_funcs(s)
    θ₁ = (θ₀ - C)*cos(w*s) + v/w*sin(w*s) + C*cos(G*s)
    Xc = R*cos(G*s)
    Yc = R*sin(G*s)
    X = Xc + l*sin(θ₁)
    Y = Yc - l*cos(θ₁)
    return Xc, Yc, X, Y
end
Xc, Yc, X, Y = update_funcs(0)

anim = @animate for s in 0:200
    # Update points
    Xc, Yc, X, Y = update_funcs(s/20)

    # Draw points
    k_means_plot = scatter(
        [X, Xc],
        [Y, Yc],
        xlim = (-5, 5),
        ylim = (-6, 3),
        title = "ODE",
        aspect_ratio = 1,
        legend = false,
    )

    # Draw line
    plot!(
        k_means_plot,
        [Xc, X],
        [Yc, Y],
    )

end

gif(anim, "ODE.gif", fps=25)
