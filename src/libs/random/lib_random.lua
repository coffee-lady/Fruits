local RandomLib = {}

function RandomLib.random(min, max)
    return math.random() * ( max - min ) + min
end

function RandomLib.random_arr(arr)
    return math.random() * ( arr[2] - arr[1] ) + arr[1]
end

function RandomLib.random_with_weights(arr)
    local total_weight = 0
    local current_weight = 0

    for _, item in pairs(arr) do
        total_weight = total_weight + item.weight
    end

    local random_weight = math.floor(math.random() * total_weight)

    for _, item in pairs(arr) do
        current_weight = current_weight + item.weight

        if current_weight >= random_weight then
            return item
        end
    end
end


return RandomLib
