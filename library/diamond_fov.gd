class_name DiamondFov


static func get_fov_map(source: Vector2i, sight_range: int,
        out_fov_map: Dictionary) -> void:
    var column: Array

    for x: int in out_fov_map.keys():
        column = out_fov_map[x]
        for y: int in range(0, column.size()):
            column[y] = ConvertCoord.is_in_range(source, Vector2i(x, y),
                    sight_range)
