# https://research.ibm.com/haifa/ponderthis/challenges/July2022.html

let
    mem = Dict()
    res = [[] for _ in 1:21]
    arlen = 0
    s = 0
    function f(arr, i)
        stop = false
        if haskey(mem,arr)
            if mem[arr] > i
                mem[arr] = i
            else
                stop = true
            end
        else
            mem[arr] = i
        end
        if !stop
            res[i] = copy(arr)
            if 0 in arr
                println("Solution:")
                println(join(filter(!isempty, res), "\n"))
                exit(86)
            elseif i <= 20
                loopy = [[-min(abs(s-2*arr[j]), abs(s-(arr[k]-arr[j]))), j, k] for k in 2:arrlen for j in 1:k-1 if arr[j]*2 <= arr[k] + arr[j]]
                sort!(loopy)
                for loop in loopy
                    j = loop[2]
                    k = loop[3]
                    if arr[j]*2 <= arr[k]+arr[j]
                        narr = copy(arr)
                        narr[k] -= arr[j]
                        narr[j] *= 2
                        sort!(narr)
                        f(narr,i+1)
                    end
                end
            end
        end
    end
    t = [855661,1395050,1402703,1575981,2956165,4346904,5516627,5693538,6096226,7359806]
    s = div(sum(t), length(t)-1)
    arrlen = length(t)
    f(t,1)
end