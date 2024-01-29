class_name ShadowCastFov


const MIN_X: int = 0
const MIN_SLOPE: float = 0.0
const MAX_SLOPE: float = 1.0


static var _fov_data: FovData = FovData.new()


# is_obstacle(from_coord: Vector2i, to_coord: Vector2i, opt_args: Array) -> bool
static func get_fov_map(source: Vector2i, sight_range: int,
        is_obstacle: Callable, is_obstacle_args: Array, out_fov_map: Dictionary,
        fov_data: FovData = ShadowCastFov._fov_data) -> void:
    Map2D.reset_map(false, out_fov_map)
    _set_octant_map(source, sight_range, is_obstacle, is_obstacle_args,
            out_fov_map, MIN_X, MIN_SLOPE, MAX_SLOPE)


static func _set_octant_map(source: Vector2i, sight_range: int,
        is_obstacle: Callable, is_obstacle_args: Array, out_fov_map: Dictionary,
        min_x: int, min_slope: float, max_slope: float) -> void:
    var min_y: int
    var max_y: int
    var coord: Vector2i = Vector2i(0, 0)

    for x: int in range(min_x, sight_range + 1):
        min_y = _get_y(x, min_slope)
        max_y = _get_y(x, max_slope)
        for y: int in range(max_y, min_y - 1, -1):
            coord.x = source.x + x
            coord.y = source.y + y
            out_fov_map[coord.x][coord.y] = true


static func _get_slope(this_coord: Vector2i, that_coord: Vector2i) -> float:
    return (that_coord.y - this_coord.y) * 1.0 / (that_coord.x - this_coord.x)


static func _get_y(x: int, slope: float) -> int:
    return floor(x * slope)


class FovData:
    pass
