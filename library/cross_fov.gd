class_name CrossFov


# is_obstacle(from_coord: Vector2i, to_coord: Vector2i, opt_args: Array) -> bool
static func get_fov_map(source: Vector2i, sight_ranges: SightRanges,
        is_obstacle: Callable, is_obstacle_args: Array,
        out_fov_map: Dictionary) -> void:
    var up_left: Vector2i = source
    var down_right: Vector2i = source
    var coords: Array
    var coord: Vector2i
    var __: int

    Map2D.reset_map(false, out_fov_map)

    coords = CastRay.get_coords(source, source + Vector2i.UP, is_obstacle,
            is_obstacle_args, true, false)

    if coords.size() > sight_ranges.up:
        __ = coords.resize(sight_ranges.up)
    if coords.is_empty():
        coord = source
    else:
        coord = coords.pop_back()
    up_left.y = coord.y

    coords = CastRay.get_coords(source, source + Vector2i.LEFT, is_obstacle,
            is_obstacle_args, true, false)
    if coords.size() > sight_ranges.left:
        __ = coords.resize(sight_ranges.left)
    if coords.is_empty():
        coord = source
    else:
        coord = coords.pop_back()
    up_left.x = coord.x

    coords = CastRay.get_coords(source, source + Vector2i.DOWN, is_obstacle,
            is_obstacle_args, true, false)
    if coords.size() > sight_ranges.down:
        __ = coords.resize(sight_ranges.down)
    if coords.is_empty():
        coord = source
    else:
        coord = coords.pop_back()
    down_right.y = coord.y

    coords = CastRay.get_coords(source, source + Vector2i.RIGHT, is_obstacle,
            is_obstacle_args, true, false)
    if coords.size() > sight_ranges.right:
        __ = coords.resize(sight_ranges.right)
    if coords.is_empty():
        coord = source
    else:
        coord = coords.pop_back()
    down_right.x = coord.x

    for x: int in range(source.x - sight_ranges.half_width,
            source.x + sight_ranges.half_width + 1):
        for y: int in range(up_left.y, down_right.y + 1):
            if Map2D.is_in_map(Vector2i(x, y), out_fov_map):
                out_fov_map[x][y] = true
    for y: int in range(source.y - sight_ranges.half_width,
            source.y + sight_ranges.half_width + 1):
        for x: int in range(up_left.x, down_right.x + 1):
            if Map2D.is_in_map(Vector2i(x, y), out_fov_map):
                out_fov_map[x][y] = true


class SightRanges:
    var half_width: int:
        get:
            return _half_width
    var up: int:
        get:
            return _up
    var down: int:
        get:
            return _down
    var left: int:
        get:
            return _left
    var right: int:
        get:
            return _right


    var _half_width: int
    var _up: int
    var _down: int
    var _left: int
    var _right: int


    func _init(half_width_: int, up_: int, down_: int, left_: int,
            right_: int) -> void:
        _half_width = half_width_
        _up = up_
        _down = down_
        _left = left_
        _right = right_
