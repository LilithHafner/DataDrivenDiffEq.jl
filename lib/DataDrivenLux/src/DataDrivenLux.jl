module DataDrivenLux

using DataDrivenDiffEq

# Load specific (abstract) types
using DataDrivenDiffEq: AbstractBasis
using DataDrivenDiffEq: AbstractDataDrivenAlgorithm
using DataDrivenDiffEq: AbstractDataDrivenResult
using DataDrivenDiffEq: AbstractDataDrivenProblem
using DataDrivenDiffEq: DDReturnCode, ABSTRACT_CONT_PROB, ABSTRACT_DISCRETE_PROB
using DataDrivenDiffEq: InternalDataDrivenProblem
using DataDrivenDiffEq: is_implicit, is_controlled

using DataDrivenDiffEq.DocStringExtensions
using DataDrivenDiffEq.CommonSolve
using DataDrivenDiffEq.CommonSolve: solve!
using DataDrivenDiffEq.StatsBase
using DataDrivenDiffEq.Parameters
using DataDrivenDiffEq.Setfield


using Reexport
@reexport using Optim
using Lux
using TransformVariables
using NNlib
using Distributions
using DistributionsAD
using ChainRulesCore
using ComponentArrays
# We only need a certain subset of IntervalArithmetic
using IntervalArithmetic
using Random
using Distributed
using ProgressMeter
using Suppressor

abstract type AbstractAlgorithmCache end
abstract type AbstractDAGSRAlgorithm <: AbstractDataDrivenAlgorithm end
abstract type AbstractSimplex end
abstract type AbstractErrorModel end
abstract type AbstractErrorDistribution end
abstract type AbstractConfigurationCache <: StatsBase.StatisticalModel end

##
include("utils.jl")

## 
include("custom_priors.jl")
export AdditiveError, MultiplicativeError
export ObservedModel

# Simplex
include("./lux/simplex.jl")
export Softmax, GumbelSoftmax

# Nodes and Layers
include("./lux/path_state.jl")
export PathState
include("./lux/node.jl")
export DecisionNode
export update_state, get_inputs, get_loglikelihood
include("./lux/layer.jl")
export DecisionLayer
include("./lux/graph.jl")
export LayeredDAG

include("algorithms/dataset.jl")

include("caches/candidate.jl")
export Candidate
export get_loglikelihood

include("caches/cache.jl")
export SearchCache

include("algorithms/randomsearch.jl")
export RandomSearch

include("solve.jl")

end # module DataDrivenLux
