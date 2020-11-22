local RandomLib = {}

function RandomLib.random(min, max)
    return math.random() * ( max - min ) + min   
end 

function RandomLib.random_arr(arr)
    return math.random() * ( arr[2] - arr[1] ) + arr[1]   
end 

return RandomLib
