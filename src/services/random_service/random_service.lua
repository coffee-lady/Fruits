local random_service = {}

function random_service.random(min, max)
    return math.random() * ( max - min ) + min   
end 

function random_service.random_arr(arr)
    return math.random() * ( arr[2] - arr[1] ) + arr[1]   
end 

return random_service
