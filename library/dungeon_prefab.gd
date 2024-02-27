class_name DungeonPrefab


enum {
    DO_NOT_EDIT,
    HORIZONTAL_FLIP,
    VERTICAL_FLIP,
    ROTATE_RIGHT,
}


const DICT_VALUE_WARNING: String = "Dict value is neither a string or an array."


# parsed_file: {row: [column]}
# edit_tags: HORIZONTAL_FLIP | VERTICAL_FLIP | ROTATE_RIGHT
static func get_prefab(parsed_file: Dictionary, edit_tags: Array = []) \
        -> PackedPrefab:
    var prefab: Dictionary = {}
    var matrix_size: MatrixSize = _get_matrix_size(parsed_file)
    var max_x: int = matrix_size.max_column
    var max_y: int = matrix_size.max_row
    var new_row: Array
    var __: int
    var refresh_size: bool = false

    # The file is read by lines. Therefore in order to get a grid [x, y], we
    # need to call output_line[y][x], which is inconvenient. Swap [x, y] and
    # [y, x] to make life easier.
    #
    # column
    # ----------> x
    # |
    # | row
    # |
    # v y
    for x: int in range(0, max_x):
        new_row = []
        __ = new_row.resize(max_y)
        prefab[x] = new_row
        for y: int in range(0, max_y):
            prefab[x][y] = parsed_file[y][x]

    for i: int in edit_tags:
        match i:
            HORIZONTAL_FLIP:
                prefab = _horizontal_flip(prefab, max_x, max_y)
            VERTICAL_FLIP:
                prefab = _vertical_flip(prefab, max_x, max_y)
            ROTATE_RIGHT:
                prefab = _rotate_right(prefab, max_x, max_y)
                refresh_size = true
        # Update max_x and max_y after the prefab is rotated.
        if refresh_size:
            matrix_size = _get_matrix_size(prefab)
            max_x = matrix_size.max_row
            max_y = matrix_size.max_column
            refresh_size = false
    return PackedPrefab.new(prefab, max_x, max_y)


static func _horizontal_flip(prefab: Dictionary, max_x: int, max_y: int) \
        -> Dictionary:
    var mirror: int

    for y: int in range(0, max_y):
        for x: int in range(0, max_x):
            mirror = max_x - x - 1
            if x > mirror:
                break
            _swap_matrix_value(prefab, Vector2i(x, y), Vector2i(mirror, y))
    return prefab


static func _vertical_flip(prefab: Dictionary, max_x: int, max_y: int) \
        -> Dictionary:
    var mirror: int

    for x: int in range(0, max_x):
        for y: int in range(0, max_y):
            mirror = max_y - y - 1
            if y > mirror:
                break
            _swap_matrix_value(prefab, Vector2i(x, y), Vector2i(x, mirror))
    return prefab


static func _rotate_right(prefab: Dictionary, max_x: int, max_y: int) \
    -> Dictionary:
    var new_prefab: Dictionary = {}
    var new_row: Array
    var new_x: int
    var new_y: int
    var __: int

    for x: int in range(0, max_y):
        new_row = []
        __ = new_row.resize(max_x)
        new_prefab[x] = new_row
    for x: int in range(0, max_x):
        for y: int in range(0, max_y):
            new_x = max_y - y - 1
            new_y = x
            new_prefab[new_x][new_y] = prefab[x][y]
    return new_prefab


static func _get_matrix_size(matrix_dict: Dictionary) -> MatrixSize:
    var max_row: int = matrix_dict.size()
    var max_column: int = 0
    var string_line: String
    var array_line: Array

    if max_row > 0:
        match typeof(matrix_dict[0]):
            TYPE_STRING:
                string_line = matrix_dict[0]
                max_column = string_line.length()
            TYPE_ARRAY:
                array_line = matrix_dict[0]
                max_column = array_line.size()
            _:
                push_warning(DICT_VALUE_WARNING)
    return MatrixSize.new(max_row, max_column)


static func _swap_matrix_value(matrix: Dictionary, this_coord: Vector2i,
        that_coord: Vector2i) -> void:
    var save_char: String = matrix[this_coord.x][this_coord.y]

    matrix[this_coord.x][this_coord.y] = matrix[that_coord.x][that_coord.y]
    matrix[that_coord.x][that_coord.y] = save_char


class PackedPrefab:
    var max_x: int:
        get:
            return _max_x
    var max_y: int:
        get:
            return _max_y
    var prefab: Dictionary:
        get:
            return _prefab

    var _max_x: int
    var _max_y: int
    var _prefab: Dictionary


    func _init(prefab_: Dictionary, max_x_: int, max_y_: int) -> void:
        _prefab = prefab_
        _max_x = max_x_
        _max_y = max_y_


class MatrixSize:
    var max_row: int:
        get:
            return _max_row
    var max_column: int:
        get:
            return _max_column

    var _max_row: int
    var _max_column: int


    func _init(max_row_: int, max_column_: int) -> void:
        _max_row = max_row_
        _max_column = max_column_
