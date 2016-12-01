function clamp(v, min, max)
    return (v < min and min) or (v > max and max) or v
end

-- magnitude of difference between positions to get distance
function distance(p1, p2)
    return (p1 - p2):len()
end

-- circle intersection because i am hella lazy
function are_colliding(thing_one, thing_two)
    if thing_one.radius and thing_two.radius then
        return distance(thing_one.loc, thing_two.loc) < (thing_one.radius + thing_two.radius)
    else
        return false
    end

end

function point_inside_box(pos, x, y, w, h)
    return pos.x < x + w and pos.x > x and pos.y > y and pos.y < y + h
end
