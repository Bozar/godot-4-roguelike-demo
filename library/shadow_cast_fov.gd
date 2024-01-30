class_name ShadowCastFov


# Recursive Shadow Casting Field of View
#
# http://www.roguebasin.com/index.php?title=FOV_using_recursive_shadowcasting
#
#   \ 5 | 6 /
#    \  |  /
#   4 \ | / 7
# ------@------>
#   3 / | \ 0
#    /  |  \
#   / 2 | 1 \
#       |
#       v
#


const MIN_X: int = 0
const MIN_SLOPE: float = 0.0
const MAX_SLOPE: float = 1.0


static var _fov_data: FovData = FovData.new()


# is_obstacle(from_coord: Vector2i, to_coord: Vector2i, opt_args: Array) -> bool
static func get_fov_map(source: Vector2i, sight_range: int,
        is_obstacle: Callable, is_obstacle_args: Array, out_fov_map: Dictionary,
        fov_data: FovData = ShadowCastFov._fov_data) -> void:
    Map2D.reset_map(false, out_fov_map)
    out_fov_map[source.x][source.y] = true
    _set_octant_map(source, sight_range, is_obstacle, is_obstacle_args,
            out_fov_map, MIN_X, MIN_SLOPE, MAX_SLOPE)


static func _set_octant_map(source: Vector2i, sight_range: int,
        is_obstacle: Callable, is_obstacle_args: Array, out_fov_map: Dictionary,
        min_x: int, min_slope: float, max_slope: float) -> void:
    var break_loop: bool
    var hit_obstacle: bool
    var new_min_slope: float = min_slope
    var new_max_slope: float = max_slope
    var min_y: int
    var max_y: int
    var coord: Vector2i = Vector2i(0, 0)

    # Start scanning one grid away from source.
    for x: int in range(min_x + 1, sight_range + 1):
        # By default, scan only one row or column.
        break_loop = true
        hit_obstacle = false
        min_y = floor(x * new_min_slope)
        max_y = ceil(x * new_max_slope)

        for y: int in range(max_y, min_y - 1, -1):
            coord.x = source.x + x
            coord.y = source.y + y
            if not Map2D.is_in_map(coord, out_fov_map):
                continue
            # The current row or column is always visible.
            out_fov_map[coord.x][coord.y] = true

            if is_obstacle.call(source, coord, is_obstacle_args):
                # If this is not the first obstacle in a row, go past it.
                if hit_obstacle:
                    continue
                hit_obstacle = true

                # `new_min_slope` should be one grid lower than the first
                # obstacle, and higher than `new_max_slope`.
                if y + 1 > max_y:
                    continue
                new_min_slope = _get_slope(x, y + 1)
                # Call `_set_octant_map` recursively, starting from `x`. Note
                # that actual scanning begins at `x + 1`.
                _set_octant_map(source, sight_range, is_obstacle,
                        is_obstacle_args, out_fov_map, x, new_min_slope,
                        new_max_slope)
            else:
                # Update `new_max_slope` when reach the first unoccupied grid.
                if hit_obstacle:
                    hit_obstacle = false
                    new_max_slope = _get_slope(x, y)
                # Scan the next row or column (`x + 1`) if and only if the last
                # grid is unoccupied.
                if y == min_y:
                    break_loop = false
        if break_loop:
            break


static func _get_slope(delta_x: int, delta_y: int) -> float:
    return delta_y * 1.0 / delta_x


class FovData:
    pass
