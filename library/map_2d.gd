class_name Map2D


static func init_map(value: Variant = null, max_x: int = DungeonSize.MAX_X,
    max_y: int = DungeonSize.MAX_Y) -> Dictionary:
    var map: Dictionary = {}
    var column: Array
    var __: int

    for x: int in range(0, max_x):
        column = []
        __ = column.resize(max_y)
        column.fill(value)
        map[x] = column
    return map


static func reset_map(value: Variant, out_map: Dictionary) -> void:
    var column: Array

    for x: int in out_map.keys():
        column = out_map[x]
        column.fill(value)


static func is_in_map(coord: Vector2i, map: Dictionary) -> bool:
    var column: Array

    if map.has(coord.x):
        column = map[coord.x]
        return (coord.y >= 0) and (coord.y < column.size())
    return false
