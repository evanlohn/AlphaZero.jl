#####
##### AlphaZero.jl
##### Jonathan Laurent, Carnegie Mellon University (2019)
#####

module AlphaZero

export MCTS, MinMax, GameInterface, GI, Report, Network, Benchmark
export RolloutsValidation
export AbstractSchedule, PLSchedule, StepSchedule
export Params, MctsParams
export ColorPolicy, ALTERNATE_COLORS, BASELINE_WHITE, CONTENDER_WHITE
export SelfPlayParams, ArenaParams, LearningParams, MemAnalysisParams
export Env, train!, learning!, self_play!, memory_report, get_experience
export Session, resume!, save, explore, play_game, run_new_benchmark
export SimpleNet, SimpleNetHP, ResNet, ResNetHP

include("util.jl")
import .Util
using .Util: Option, @unimplemented

include("game.jl")
import .GameInterface
const GI = GameInterface

include("minmax.jl")
import .MinMax

include("mcts.jl")
import .MCTS

include("networks/network.jl")
using .Network

include("ui/log.jl")
using .Log

import Plots
import Colors
import JSON2

using Formatting
using Crayons
using Colors: @colorant_str
using ProgressMeter
using Base: @kwdef
using Serialization: serialize, deserialize
using DataStructures: Stack, CircularBuffer
using Distributions: Categorical, Dirichlet
using Statistics: mean

include("schedule.jl")
include("params.jl")
include("report.jl")
include("memory.jl")
include("learning.jl")
include("play.jl")
include("training.jl")

include("benchmark.jl")
using .Benchmark

include("ui/explorer.jl")
include("ui/plots.jl")
include("ui/session.jl")

# We support Flux and Knet
const USE_KNET = true

if USE_KNET
  @eval begin
    include("networks/knet.jl")
    using .KNets
  end
else
  @eval begin
    include("networks/flux.jl")
    using .FluxNets
  end
end

end

# External resources on AlphaZero and MCTS:
# + https://web.stanford.edu/~surag/posts/alphazero.html
# + https://int8.io/monte-carlo-tree-search-beginners-guide/
# + https://medium.com/oracledevs/lessons-from-alpha-zero