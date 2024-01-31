class_name CrossFov


# is_obstacle(from_coord: Vector2i, to_coord: Vector2i, opt_args: Array) -> bool
static func get_fov_map(source: Vector2i, sight_range: int, half_width: int,
        is_obstacle: Callable, is_obstacle_args: Array,
        out_fov_map: Dictionary, fov_data: FovData = FovData.new(half_width,
        sight_range, sight_range, sight_range, sight_range)) -> void:
    var up_left: Vector2i = Vector2i(0, 0)
    var down_right: Vector2i = Vector2i(0, 0)

    Map2D.reset_map(false, out_fov_map)

    up_left.y = _get_end_point(source, Vector2i.UP, fov_data.up,
            is_obstacle, is_obstacle_args).y
    up_left.x = _get_end_point(source, Vector2i.LEFT, fov_data.left,
            is_obstacle, is_obstacle_args).x

    down_right.y = _get_end_point(source, Vector2i.DOWN, fov_data.down,
            is_obstacle, is_obstacle_args).y
    down_right.x = _get_end_point(source, Vector2i.RIGHT, fov_data.right,
            is_obstacle, is_obstacle_args).x

    CrossFov._set_fov_map(source, fov_data.half_width, up_left, down_right,
            out_fov_map)


static func _get_end_point(source: Vector2i, direction: Vector2i,
        sight_range: int, is_obstacle: Callable, is_obstacle_args: Array) \
        -> Vector2i:
    var coords: Array

    coords = CastRay.get_coords(source, source + direction, CrossFov._block_ray,
            [sight_range, is_obstacle, is_obstacle_args], true, false)
    if coords.is_empty():
        return source
    return coords.pop_back()


static func _block_ray(from_coord: Vector2i, to_coord: Vector2i, args: Array) \
        -> bool:
    var sight_range: int = args[0]
    var is_obstacle: Callable = args[1]
    var is_obstacle_args: Array = args[2]

    if ConvertCoord.get_range(from_coord, to_coord) >= sight_range:
        return true
    return is_obstacle.call(from_coord, to_coord, is_obstacle_args)


static func _set_fov_map(source: Vector2i, half_width: int, up_left: Vector2i,
        down_right: Vector2i, out_fov_map: Dictionary) -> void:
    var x_left: int = source.x - half_width
    var x_right: int = source.x + half_width
    var y_up: int = source.y - half_width
    var y_down: int = source.y + half_width
    var coord: Vector2i = Vector2i(0, 0)

    for x: int in range(up_left.x, down_right.x + 1):
        for y: int in range(up_left.y, down_right.y + 1):
            coord.x = x
            coord.y = y
            if (x >= x_left) and (x <= x_right) and Map2D.is_in_map(coord,
                    out_fov_map):
                out_fov_map[x][y] = true
            elif (y >= y_up) and (y <= y_down) and Map2D.is_in_map(coord,
                    out_fov_map):
                out_fov_map[x][y] = true


class FovData:
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
