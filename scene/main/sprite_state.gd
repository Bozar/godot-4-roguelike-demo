class_name SpriteState
extends Node2D


var _palette: Dictionary = {}
var _pc: Sprite2D


@onready var _ref_SpriteTag: SpriteTag = $SpriteTag
# @onready var _ref_SearchByTag: SearchByTag = $SearchByTag
@onready var _ref_DungeonBoard: DungeonBoard = $DungeonBoard


func _on_InitWorld_sprites_created(sprites: Array[TaggedSprite]) -> void:
    # TODO: Verify palette in node `LoadSetting`.
    _palette = Palette.get_verified_palette(_palette)

    RenderingServer.set_default_clear_color(Palette.get_color(_palette,
            MainTag.BACKGROUND, true))

    for ts: TaggedSprite in sprites:
        ts.sprite.modulate = Palette.get_color(_palette, ts.main_tag, true)
        _ref_SpriteTag.add_state(ts.sprite, ts.main_tag, ts.sub_tag)

        if ts.main_tag != MainTag.INDICATOR:
            _ref_DungeonBoard.add_state(ts.sprite, ts.main_tag)
        if ts.sub_tag == SubTag.PC:
            _pc = ts.sprite


func _on_PlayerInput_pc_moved(direction: StringName) -> void:
    var coord: Vector2i = ConvertCoord.get_coord(_pc)

    match direction:
        InputTag.MOVE_LEFT:
            coord += Vector2i.LEFT
        InputTag.MOVE_RIGHT:
            coord += Vector2i.RIGHT
        InputTag.MOVE_UP:
            coord += Vector2i.UP
        InputTag.MOVE_DOWN:
            coord += Vector2i.DOWN
    _move_sprite(_pc, coord)


func _set_light_color(sprite: Sprite2D) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)
    sprite.modulate = Palette.get_color(_palette, main_tag, true)


func _set_dark_color(sprite: Sprite2D) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)
    sprite.modulate = Palette.get_color(_palette, main_tag, false)


func _move_sprite(sprite: Sprite2D, coord: Vector2i,
        z_layer: int = sprite.z_index) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(sprite)

    _ref_DungeonBoard.remove_state(sprite, main_tag)
    sprite.position = ConvertCoord.get_position(coord)
    sprite.z_index = z_layer
    _ref_DungeonBoard.add_state(sprite, main_tag)


func _swap_sprite(this_sprite: Sprite2D, that_sprite: Sprite2D) -> void:
    var main_tag: StringName = _ref_SpriteTag.get_main_tag(this_sprite)
    if main_tag != _ref_SpriteTag.get_main_tag(that_sprite):
        push_error("Main tags do not match: %s, %s." %
                [this_sprite.name, that_sprite.name])
        return

    var this_coord: Vector2i = ConvertCoord.get_coord(this_sprite)
    var this_layer: int = this_sprite.z_index
    var that_coord: Vector2i = ConvertCoord.get_coord(that_sprite)
    var that_layer: int = that_sprite.z_index

    _move_sprite(this_sprite, that_coord, 0)
    _move_sprite(that_sprite, this_coord, this_layer)
    _move_sprite(this_sprite, that_coord, that_layer)
