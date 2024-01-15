class_name SignalConnectionData


const INIT_WORLD: String = "InitWorld"
const SPRITE_ROOT: String = "SpriteRoot"
const SPRITE_STATE: String = "SpriteState"
const PLAYER_INPUT: String = "PlayerInput"

const SEARCH_SPRITE: String = "/root/SearchSprite"


const SIGNAL_SPRITES_CREATED: String = "sprites_created"
const SIGNAL_PC_MOVED: String = "pc_moved"
const SIGNAL_SEARCHING_BY_TAG: String = "searching_by_tag"
const SIGNAL_SEARCHING_BY_COORD: String = "searching_by_coord"


# {source_node: {signal_name: [target_node_1, ...]}, ...}
const SIGNAL_CONNECTIONS: Dictionary = {
    INIT_WORLD: {
        SIGNAL_SPRITES_CREATED: [
            SPRITE_ROOT, SPRITE_STATE,
        ],
    },
    PLAYER_INPUT: {
        SIGNAL_PC_MOVED: [
            SPRITE_STATE,
        ],
    },
    SEARCH_SPRITE: {
        SIGNAL_SEARCHING_BY_COORD: [
            SPRITE_STATE,
        ],
        SIGNAL_SEARCHING_BY_TAG: [
            SPRITE_STATE,
        ],
    },
}
