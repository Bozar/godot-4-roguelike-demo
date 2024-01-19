class_name CastRay


# is_obstacle(from_coord: Vector2i, to_coord: Vector2i, opt_args: Array) -> bool
static func get_coords(from_coord: Vector2i, to_coord: Vector2i,
        is_obstacle: Callable, is_obstacle_args: Array, trim_head: bool,
        trim_tail: bool) -> Array:
    var direction: Vector2i
    var ray_coords: Array = []
    var this_coord: Vector2i

    if from_coord.x == to_coord.x:
        if from_coord.y > to_coord.y:
            direction = Vector2i.UP
        elif from_coord.y < to_coord.y:
            direction = Vector2i.DOWN
    elif from_coord.y == to_coord.y:
        if from_coord.x > to_coord.x:
            direction = Vector2i.LEFT
        elif from_coord.x < to_coord.x:
            direction = Vector2i.RIGHT
    else:
        push_error("Invalid coords: %s, %s" % [from_coord, to_coord])
        return ray_coords

    this_coord = from_coord
    while true:
        ray_coords.push_back(this_coord)
        this_coord += direction
        if is_obstacle.call(from_coord, this_coord, is_obstacle_args):
            ray_coords.push_back(this_coord)
            break
    return trim_coords(ray_coords, trim_head, trim_tail)


# Remove starting point and/or the last coord if it is outside dungeon.
static func trim_coords(coords: Array, trim_head: bool, trim_tail: bool) \
        -> Array:
    var trimmed: Array = coords
    var coord: Vector2i

    if trim_head and (trimmed.size() > 1):
        trimmed = trimmed.slice(1)
    if trim_tail and (trimmed.size() > 0):
        coord = trimmed.back()
        if not DungeonSize.is_insided_dungeon(coord):
            trimmed = trimmed.slice(0, -1)
    return trimmed
