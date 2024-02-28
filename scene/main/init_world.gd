class_name InitWorld
extends Node2D


const INDICATOR_OFFSET: int = 32

const PATH_TO_PREFAB: StringName = "resource/dungeon_prefab/"
const MAX_PREFABS_PER_ROW: int = 3
const MAX_PREFABS: int = 9
const EDIT_TAGS: Array = [
    DungeonPrefab.VERTICAL_FLIP, DungeonPrefab.HORIZONTAL_FLIP
]

const WALL_CHAR: StringName = "#"
const TRAP_CHAR: StringName = "?"
const GRUNT_CHAR: StringName = "G"


var _ref_RandomNumber: RandomNumber


func create_world() -> void:
    var tagged_sprites: Array[TaggedSprite] = []
    var pc_coord: Vector2i

    pc_coord = _create_pc(tagged_sprites)
    _create_floor(tagged_sprites)
    _create_from_file(tagged_sprites)
    _create_indicator(pc_coord, tagged_sprites)

    SpriteFactory.create_sprites(tagged_sprites)


func _create_pc(tagged_sprites: Array[TaggedSprite]) -> Vector2i:
    var pc_coord: Vector2i = Vector2i(0, 0)
    tagged_sprites.push_back(CreateSprite.create_actor(SubTag.PC, pc_coord))
    return pc_coord


func _create_from_file(tagged_sprites: Array[TaggedSprite]) -> void:
    var prefabs: Array = FileIo.get_files(PATH_TO_PREFAB)
    var file_name: String
    var parsed: ParsedFile
    var packed_prefab: DungeonPrefab.PackedPrefab
    var shift_coord: Vector2i = Vector2i(0, 0)
    var row: int = 0

    ArrayHelper.shuffle(prefabs, _ref_RandomNumber)
    prefabs.resize(MAX_PREFABS)
    for i: int in range(0, prefabs.size()):
        file_name = prefabs[i]
        parsed = FileIo.read_as_line(file_name)
        if not parsed.parse_success:
            return

        packed_prefab = DungeonPrefab.get_prefab(parsed.output_line,
                _get_edit_tags())

        if (i > 0) and (i % MAX_PREFABS_PER_ROW == 0):
            row += 1
        shift_coord.x = (i - MAX_PREFABS_PER_ROW * row) * packed_prefab.max_x
        shift_coord.y = row * packed_prefab.max_y

        _create_sprite(packed_prefab, shift_coord, tagged_sprites)


func _create_sprite(packed_prefab: DungeonPrefab.PackedPrefab,
        shift_coord: Vector2i, tagged_sprites: Array[TaggedSprite]) -> void:
    var new_x: int
    var new_y: int

    for y: int in range(0, packed_prefab.max_y):
        for x: int in range(0, packed_prefab.max_x):
            new_x = x + shift_coord.x
            new_y = y + shift_coord.y
            match packed_prefab.prefab[x][y]:
                WALL_CHAR:
                    tagged_sprites.push_back(CreateSprite.create_building(
                            SubTag.WALL, Vector2i(new_x, new_y)))
                GRUNT_CHAR:
                    tagged_sprites.push_back(CreateSprite.create_actor(
                            SubTag.GRUNT, Vector2i(new_x, new_y)))
                TRAP_CHAR:
                    tagged_sprites.push_back(CreateSprite.create_trap(
                            SubTag.AMMO, Vector2i(new_x, new_y)))


func _create_floor(tagged_sprites: Array[TaggedSprite]) -> void:
    for x: int in range(0, DungeonSize.MAX_X):
        for y: int in range(0, DungeonSize.MAX_Y):
            tagged_sprites.push_back(CreateSprite.create_ground(
                    SubTag.DUNGEON_FLOOR, Vector2i(x, y)))


func _create_indicator(coord: Vector2i, tagged_sprites: Array[TaggedSprite]) \
        -> void:
    var indicators: Dictionary = {
        SubTag.INDICATOR_TOP: [
            Vector2i(coord.x, 0), Vector2i(0, -INDICATOR_OFFSET)
        ],
        SubTag.INDICATOR_BOTTOM: [
            Vector2i(coord.x, DungeonSize.MAX_Y - 1),
            Vector2i(0, INDICATOR_OFFSET)
        ],
        SubTag.INDICATOR_LEFT: [
            Vector2i(0, coord.y), Vector2i(-INDICATOR_OFFSET, 0)
        ],
    }
    var new_coord: Vector2i
    var new_offset: Vector2i

    for i: StringName in indicators:
        new_coord = indicators[i][0]
        new_offset = indicators[i][1]
        tagged_sprites.push_back(CreateSprite.create(MainTag.INDICATOR,
                i, new_coord, new_offset))


func _get_edit_tags() -> Array:
    var tags: Array = []

    for i: int in EDIT_TAGS:
        if _ref_RandomNumber.get_percent_chance(50):
            tags.push_back(i)
    return tags
