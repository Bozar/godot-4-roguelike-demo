class_name FovHelper


static func init_fov_map(max_x: int, max_y: int) -> Dictionary:
    var fov_map: Dictionary = {}
    var column: Array
    var __: int

    for x: int in range(0, max_x):
        column = []
        __ = column.resize(max_y)
        column.fill(false)
        fov_map[x] = column
    return fov_map


static func is_in_sight(coord: Vector2i, fov_map: Dictionary) -> bool:
    var column: Array

    if fov_map.has(coord.x):
        column = fov_map[coord.x]
        if (coord.y >= 0) and (coord.y < column.size()):
            return column[coord.y]
    return false
