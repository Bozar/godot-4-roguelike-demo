class_name SignalConnectionData


const INIT_WORLD: String = "InitWorld"
const SPRITE_ROOT: String = "SpriteRoot"
const SPRITE_STATE: String = "SpriteState"
const PLAYER_INPUT: String = "PlayerInput"
const PC_ACTION: String = "PcAction"

const SEARCH_HELPER: String = "/root/SearchHelper"
const MOVE_SPRITE: String = "/root/MoveSprite"


const SIGNAL_SPRITES_CREATED: String = "sprites_created"
const SIGNAL_PC_MOVED: String = "pc_moved"
const SIGNAL_SEARCHING_BY_TAG: String = "searching_by_tag"
const SIGNAL_SEARCHING_BY_COORD: String = "searching_by_coord"
const SIGNAL_SPRITE_MOVED: String = "sprite_moved"
const SIGNAL_SPRITE_SWAPPED: String = "sprite_swapped"
const SIGNAL_SEARCHING_BY_SPRITE: String = "searching_by_sprite"


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    INIT_WORLD: {
        SIGNAL_SPRITES_CREATED: [
            SPRITE_ROOT, SPRITE_STATE, PC_ACTION,
        ],
    },
    PLAYER_INPUT: {
        SIGNAL_PC_MOVED: [
            PC_ACTION,
        ],
    },
    SEARCH_HELPER: {
        SIGNAL_SEARCHING_BY_COORD: [
            SPRITE_STATE,
        ],
        SIGNAL_SEARCHING_BY_TAG: [
            SPRITE_STATE,
        ],
        SIGNAL_SEARCHING_BY_SPRITE: [
            SPRITE_STATE,
        ],
    },
    MOVE_SPRITE: {
        SIGNAL_SPRITE_MOVED: [
            SPRITE_STATE,
        ],
        SIGNAL_SPRITE_SWAPPED: [
            SPRITE_STATE,
        ],
    },
}
