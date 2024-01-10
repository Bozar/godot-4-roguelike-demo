class_name MainRoot
extends Node2D


# https://coolors.co/f8f9fa-e9ecef-dee2e6-ced4da-adb5bd-6c757d-495057-343a40-212529
# https://coolors.co/d8f3dc-b7e4c7-95d5b2-74c69d-52b788-40916c-2d6a4f-1b4332-081c15
# https://coolors.co/f8b945-dc8a14-b9690b-854e19-a03401
const PALETTE: Dictionary = {
    &"BACKGROUND_BLACK": "#212529",
    &"BACKGROUND_YELLOW": "#FDF6E3",
    &"LIGHT_GREY": "#ADB5BD",
    &"GREEN": "#52B788",
    &"DARK_GREEN": "#2D6A4F",
    &"GREY": "#6C757D",
    &"DARK_GREY": "#343A40",
    &"ORANGE": "#F8B945",
    &"DARK_ORANGE": "#854E19",
    &"DEBUG": "#FE4A49",
}

const START_X: int = 50
const START_Y: int = 54
const STEP_X: int = 26
const STEP_Y: int = 34


func _ready() -> void:
    RenderingServer.set_default_clear_color(PALETTE["BACKGROUND_YELLOW"])
    _create_pc()
    # _move_pc(MOVE_DOWN)
    _create_floor()


func _unhandled_input(event: InputEvent) -> void:
    for i: StringName in InputTag.MOVE_INPUTS:
        if event.is_action_pressed(i):
            _move_pc(i)


func _create_pc() -> void:
    # var pc: Sprite2D = preload("res://sprite/pc.tscn").instantiate()
    var pc: PackedScene = preload("res://sprite/pc.tscn")
    var new_pc: Sprite2D
    var new_position: Vector2i = Vector2i(0, 0)

    for i: String in [PALETTE["GREEN"]]:
    # for i: StringName in PALETTE.keys():
        new_pc = pc.instantiate()
        new_pc.position = _get_position_from_coord(new_position)
        new_pc.modulate = i
        # new_pc.modulate = PALETTE[i]
        new_pc.add_to_group(MainTag.ACTOR)
        new_pc.add_to_group(SubTag.PC)
        add_child(new_pc)
        # print(_get_coord_from_sprite(new_pc))
        new_position.x += 1


func _create_floor() -> void:
    var dungeon_floor: PackedScene = preload("res://sprite/dungeon_floor.tscn")
    var new_floor: Sprite2D

    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            new_floor = dungeon_floor.instantiate()
            new_floor.position = _get_position_from_coord(Vector2i(x, y))
            # new_floor.modulate = PALETTE["DEBUG"]
            new_floor.modulate = PALETTE["GREY"]
            new_floor.add_to_group(MainTag.GROUND)
            new_floor.add_to_group(SubTag.DUNGEON_FLOOR)
            add_child(new_floor)


func _get_position_from_coord(coord: Vector2i, \
        offset: Vector2i = Vector2i(0, 0)) -> Vector2i:
    var new_x: int = START_X + STEP_X * coord.x + offset.x
    var new_y: int = START_Y + STEP_Y * coord.y + offset.y
    return Vector2i(new_x, new_y)


func _get_coord_from_sprite(sprite: Sprite2D) -> Vector2i:
    var new_x: int = floor((sprite.position.x - START_X) / STEP_X)
    var new_y: int = floor((sprite.position.y - START_Y) / STEP_Y)
    return Vector2i(new_x, new_y)


func _move_pc(direction: StringName) -> void:
    var pc: Sprite2D = get_tree().get_first_node_in_group(SubTag.PC)
    var coord: Vector2i = _get_coord_from_sprite(pc)

    match direction:
        InputTag.MOVE_LEFT:
            coord += Vector2i.LEFT
        InputTag.MOVE_RIGHT:
            coord += Vector2i.RIGHT
        InputTag.MOVE_UP:
            coord += Vector2i.UP
        InputTag.MOVE_DOWN:
            coord += Vector2i.DOWN
    pc.position = _get_position_from_coord(coord)
